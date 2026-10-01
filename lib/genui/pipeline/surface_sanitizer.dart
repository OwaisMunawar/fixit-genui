import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/pipeline/component_validator.dart';
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:fixit/genui/pipeline/surface_draft.dart';
import 'package:genui/genui.dart';

/// Turns whatever the model produced into a surface that is guaranteed to
/// render: every component valid, a root present, no dangling references.
///
/// The strategy is "degrade, don't drop". An invalid component becomes a
/// fallback NoteCard in the same position, carrying whatever readable text it
/// had, so one bad field never costs the user the rest of the answer.
final class SurfaceSanitizer {
  SurfaceSanitizer(this._validator);

  final ComponentValidator _validator;

  static const fallbackBody =
      "Fixit couldn't display this part of the answer. Ask again if you need "
      'it.';

  (SurfaceDraft, List<PipelineIssue>) sanitize(SurfaceDraft draft) {
    final issues = <PipelineIssue>[];
    final surfaceId = draft.surfaceId;

    var components = [
      for (final component in draft.components)
        switch (_validator.check(component)) {
          ValidComponent(:final component) => component,
          final InvalidComponent invalid => _fallbackFor(
            invalid,
            surfaceId,
            issues,
          ),
        },
    ];

    components = _ensureRoot(components, surfaceId, issues);
    components = _repairStacks(components, surfaceId, issues);

    return (draft.copyWith(components: components), issues);
  }

  JsonMap _fallbackFor(
    InvalidComponent invalid,
    String surfaceId,
    List<PipelineIssue> issues,
  ) {
    issues.add(
      PipelineIssue(
        switch (invalid.reason) {
          InvalidReason.notInCatalog => IssueKind.unknownComponent,
          InvalidReason.schema => IssueKind.schemaViolation,
          InvalidReason.rule => IssueKind.ruleViolation,
        },
        invalid.errors.join('; '),
        surfaceId: surfaceId,
        componentId: invalid.id,
      ),
    );
    final salvaged = readableText(invalid.original);
    return {
      'id': invalid.id,
      'component': CatalogNames.noteCard,
      'tone': 'warning',
      'origin': 'validator',
      'body': salvaged.isEmpty ? fallbackBody : salvaged,
    };
  }

  List<JsonMap> _ensureRoot(
    List<JsonMap> components,
    String surfaceId,
    List<PipelineIssue> issues,
  ) {
    if (components.any((c) => c['id'] == SurfaceDraft.rootId)) {
      return components;
    }
    issues.add(
      PipelineIssue(
        IssueKind.missingRoot,
        'No component with id "root"',
        surfaceId: surfaceId,
      ),
    );
    final referenced = _referencedIds(components);
    final topLevel = components
        .map((c) => c['id']! as String)
        .where((id) => !referenced.contains(id))
        .toList();
    return [
      {
        'id': SurfaceDraft.rootId,
        'component': CatalogNames.responseStack,
        'children': topLevel,
      },
      ...components,
    ];
  }

  List<JsonMap> _repairStacks(
    List<JsonMap> components,
    String surfaceId,
    List<PipelineIssue> issues,
  ) {
    final ids = components.map((c) => c['id']! as String).toSet();
    final repaired = <JsonMap>[];
    for (final component in components) {
      if (component['component'] != CatalogNames.responseStack) {
        repaired.add(component);
        continue;
      }
      final children = (component['children']! as List).cast<String>();
      final kept = <String>[];
      for (final child in children) {
        if (!ids.contains(child) || child == SurfaceDraft.rootId) {
          issues.add(
            PipelineIssue(
              IssueKind.danglingChild,
              'Child "$child" does not exist',
              surfaceId: surfaceId,
              componentId: component['id'] as String?,
            ),
          );
        } else if (!kept.contains(child)) {
          kept.add(child);
        }
      }
      repaired.add({...component, 'children': kept});
    }

    // Anything the root can't reach would be invisible; surface it at the
    // end rather than lose content the model meant to show.
    final root = repaired.firstWhere((c) => c['id'] == SurfaceDraft.rootId);
    if (root['component'] == CatalogNames.responseStack) {
      final reachable = _reachableFrom(SurfaceDraft.rootId, repaired);
      final orphans = repaired
          .map((c) => c['id']! as String)
          .where((id) => !reachable.contains(id))
          .toList();
      for (final orphan in orphans) {
        issues.add(
          PipelineIssue(
            IssueKind.unreachableComponent,
            'Not referenced from root',
            surfaceId: surfaceId,
            componentId: orphan,
          ),
        );
      }
      final children = (root['children']! as List).cast<String>();
      final updatedRoot = {
        ...root,
        'children': [...children, ...orphans],
      };
      final index = repaired.indexOf(root);
      repaired[index] = updatedRoot;

      if ((updatedRoot['children']! as List).isEmpty) {
        issues.add(
          PipelineIssue(
            IssueKind.emptySurface,
            'Root stack has no children',
            surfaceId: surfaceId,
          ),
        );
        repaired[index] = {
          'id': SurfaceDraft.rootId,
          'component': CatalogNames.noteCard,
          'tone': 'warning',
          'origin': 'validator',
          'body': fallbackBody,
        };
      }
    }
    return repaired;
  }

  static Set<String> _referencedIds(List<JsonMap> components) => {
    for (final c in components)
      if (c['component'] == CatalogNames.responseStack && c['children'] is List)
        ...(c['children']! as List).whereType<String>(),
  };

  static Set<String> _reachableFrom(String rootId, List<JsonMap> components) {
    final byId = {for (final c in components) c['id']! as String: c};
    final seen = <String>{};
    final queue = [rootId];
    while (queue.isNotEmpty) {
      final id = queue.removeLast();
      if (!seen.add(id)) continue;
      final children = byId[id]?['children'];
      if (children is List) queue.addAll(children.whereType<String>());
    }
    return seen;
  }

  /// Pulls human-readable strings out of an arbitrary component, so a
  /// fallback card can still say something useful.
  static String readableText(Object? json, {int maxLength = 400}) {
    const keys = {
      'title',
      'likelyCause',
      'summary',
      'message',
      'body',
      'name',
      'label',
      'detail',
    };
    final parts = <String>[];
    void visit(Object? node) {
      if (node is Map) {
        for (final entry in node.entries) {
          final value = entry.value;
          if (keys.contains(entry.key) && value is String && value.isNotEmpty) {
            parts.add(value.trim());
          } else {
            visit(value);
          }
        }
      } else if (node is List) {
        node.forEach(visit);
      }
    }

    visit(json);
    final text = parts.join('. ');
    return text.length <= maxLength
        ? text
        : '${text.substring(0, maxLength - 3)}...';
  }
}
