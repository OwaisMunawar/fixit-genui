import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/pipeline/component_validator.dart';
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:fixit/genui/pipeline/surface_draft.dart';
import 'package:fixit/genui/pipeline/surface_sanitizer.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/responses.dart';

void main() {
  final sanitizer = SurfaceSanitizer(ComponentValidator(FixitCatalog.catalog));

  (SurfaceDraft, List<PipelineIssue>) run(List<Map<String, Object?>> c) =>
      sanitizer.sanitize(SurfaceDraft(surfaceId: 's', components: c));

  test('leaves a valid surface untouched', () {
    final (draft, issues) = run([
      stackOf(['diagnosis']),
      diagnosis,
    ]);

    expect(issues, isEmpty);
    expect(draft.components, hasLength(2));
  });

  test('replaces an invalid component with a fallback note in place', () {
    final (draft, issues) = run([
      stackOf(['diagnosis', 'checklist']),
      {...diagnosis, 'difficulty': 'trivial'},
      checklist,
    ]);

    final fallback = draft.component('diagnosis')!;
    expect(fallback['component'], 'NoteCard');
    expect(fallback['origin'], 'validator');
    expect(fallback['body'], contains('Dripping faucet'));
    expect(draft.component('checklist')!['component'], 'StepChecklist');
    expect(issues.single.kind, IssueKind.schemaViolation);
  });

  test('uses a generic message when nothing readable survives', () {
    final (draft, _) = run([
      {'id': 'root', 'component': 'Carousel', 'items': <Object>[]},
    ]);

    expect(draft.root!['body'], SurfaceSanitizer.fallbackBody);
  });

  test('promotes top-level components under a new root stack', () {
    final (draft, issues) = run([diagnosis, checklist]);

    expect(draft.root!['children'], ['diagnosis', 'checklist']);
    expect(issues.single.kind, IssueKind.missingRoot);
  });

  test('drops dangling and duplicate children', () {
    final (draft, issues) = run([
      stackOf(['diagnosis', 'ghost', 'diagnosis', 'root']),
      diagnosis,
    ]);

    expect(draft.root!['children'], ['diagnosis']);
    expect(
      issues.where((i) => i.kind == IssueKind.danglingChild),
      hasLength(2),
    );
  });

  test('appends unreachable components instead of hiding them', () {
    final (draft, issues) = run([
      stackOf(['diagnosis']),
      diagnosis,
      checklist,
    ]);

    expect(draft.root!['children'], ['diagnosis', 'checklist']);
    expect(issues.single.kind, IssueKind.unreachableComponent);
  });

  test('turns an empty root stack into a fallback note', () {
    final (draft, _) = run([
      stackOf(['ghost']),
    ]);

    expect(draft.root!['component'], 'NoteCard');
  });

  test('readableText collects nested strings and truncates', () {
    final text = SurfaceSanitizer.readableText({
      'title': 'Plan',
      'steps': [
        {'title': 'Shut off water'},
        {'title': 'Open tap'},
      ],
    });
    expect(text, 'Plan. Shut off water. Open tap');

    final long = SurfaceSanitizer.readableText({
      'body': 'x' * 500,
    }, maxLength: 20);
    expect(long, hasLength(20));
    expect(long, endsWith('...'));
  });
}
