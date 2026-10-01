import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:fixit/genui/pipeline/response_parser.dart';
import 'package:fixit/genui/pipeline/surface_draft.dart';
import 'package:genui/genui.dart';

/// Groups a turn's messages into surface drafts and gives each surface an id
/// the app controls.
///
/// Model-chosen surface ids collide across turns ("main" is popular), and
/// genui treats a duplicate `createSurface` as an error. Renaming per turn
/// makes ids unique for the life of a job.
final class TurnAssembler {
  const TurnAssembler();

  TurnDraft assemble(ParsedResponse parsed, {required String surfacePrefix}) {
    final issues = [...parsed.issues];
    final groups = <String, _SurfaceGroup>{};

    _SurfaceGroup groupFor(String modelId) => groups.putIfAbsent(
      modelId,
      () => _SurfaceGroup('$surfacePrefix-${groups.length}'),
    );

    for (final message in parsed.messages) {
      switch (message) {
        case core.CreateSurfaceMessage(:final surfaceId):
          groupFor(surfaceId);
        case core.UpdateComponentsMessage(:final surfaceId, :final components):
          // Lenient on purpose: models often skip createSurface. The intent
          // is unambiguous, so create it rather than drop the answer.
          final group = groupFor(surfaceId);
          for (final component in components) {
            group.put(Map<String, Object?>.from(component), issues);
          }
        case core.UpdateDataModelMessage(:final surfaceId, :final path):
          final group = groups[surfaceId];
          final target = path ?? '/';
          if (group == null) {
            issues.add(
              PipelineIssue(
                IssueKind.orphanUpdate,
                'Data update for a surface outside this turn',
                surfaceId: surfaceId,
              ),
            );
          } else if (target.startsWith('/fixit')) {
            issues.add(
              PipelineIssue(
                IssueKind.reservedPath,
                'The model may not write $target',
                surfaceId: surfaceId,
              ),
            );
          } else {
            group.dataUpdates.add(
              DataUpdate(path: target, value: message.value),
            );
          }
        case core.DeleteSurfaceMessage(:final surfaceId):
          issues.add(
            PipelineIssue(
              IssueKind.disallowedOperation,
              'deleteSurface is not allowed in a job timeline',
              surfaceId: surfaceId,
            ),
          );
      }
    }

    final surfaces = <SurfaceDraft>[];
    for (final group in groups.values) {
      if (group.components.isEmpty) {
        issues.add(
          PipelineIssue(
            IssueKind.emptySurface,
            'Surface had no components',
            surfaceId: group.id,
          ),
        );
        continue;
      }
      surfaces.add(
        SurfaceDraft(
          surfaceId: group.id,
          components: group.components.values.toList(),
          dataUpdates: List.unmodifiable(group.dataUpdates),
        ),
      );
    }

    return TurnDraft(surfaces: surfaces, text: parsed.text, issues: issues);
  }

  /// Wraps prose in a NoteCard surface so every turn renders as UI and is
  /// persisted the same way.
  static SurfaceDraft noteSurface(
    String surfaceId,
    String body, {
    bool isFallback = false,
  }) => SurfaceDraft(
    surfaceId: surfaceId,
    components: [
      {
        'id': SurfaceDraft.rootId,
        'component': CatalogNames.noteCard,
        'body': body,
        if (isFallback) ...{'tone': 'warning', 'origin': 'validator'},
      },
    ],
  );
}

class _SurfaceGroup {
  _SurfaceGroup(this.id);

  final String id;

  /// Keyed by component id; a later definition replaces an earlier one but
  /// keeps its position, matching how genui applies updateComponents.
  final Map<String, JsonMap> components = {};
  final List<DataUpdate> dataUpdates = [];
  int _anonymous = 0;

  void put(JsonMap component, List<PipelineIssue> issues) {
    final id = component['id'];
    if (id is String && id.trim().isNotEmpty) {
      components[id] = component;
      return;
    }
    final generated = 'auto_${_anonymous++}';
    issues.add(
      PipelineIssue(
        IssueKind.missingId,
        'Component without an id',
        surfaceId: this.id,
        componentId: generated,
      ),
    );
    components[generated] = {...component, 'id': generated};
  }
}
