import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/guardrails/safety_guardrail.dart';
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:fixit/genui/pipeline/turn_pipeline.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/responses.dart';

void main() {
  final pipeline = TurnPipeline(catalog: FixitCatalog.catalog);

  test('a clean response passes through with its prose', () async {
    final turn = await pipeline.process(
      rawResponse([
        stackOf(['diagnosis']),
        diagnosis,
      ], text: 'Easy one.'),
      surfacePrefix: 't0',
    );

    expect(turn.issues, isEmpty);
    expect(turn.text, 'Easy one.');
    expect(turn.surfaceIds, ['t0-0']);
    expect(turn.guardrail.intervened, isFalse);
    expect(turn.diagnosedCategories, {RepairCategory.plumbing});
  });

  test('prose-only answers become a note card', () async {
    final turn = await pipeline.process(
      'Turn the water off first.',
      surfacePrefix: 't1',
    );

    expect(turn.surfaces.single.root!['component'], 'NoteCard');
    expect(turn.surfaces.single.root!['body'], 'Turn the water off first.');
    expect(turn.text, isEmpty, reason: 'shown once, as the card');
  });

  test('an empty or unusable response still renders a fallback', () async {
    final turn = await pipeline.process(
      '```json\n{"version": "v0.9", "deleteSurface": {"surfaceId": "x"}}\n```',
      surfacePrefix: 't1',
    );

    expect(turn.surfaces.single.root!['origin'], 'validator');
    expect(
      turn.issues.map((i) => i.kind),
      contains(IssueKind.emptyResponse),
    );
  });

  test('earlier turns keep a job hazardous', () async {
    final turn = await pipeline.process(
      rawResponse([
        stackOf(['checklist']),
        checklist,
      ]),
      surfacePrefix: 't2',
      context: const JobContext(
        userTexts: ['The breaker trips'],
        diagnosedCategories: {RepairCategory.electrical},
      ),
    );

    final surface = turn.surfaces.single;
    expect(surface.component(SafetyGuardrail.bannerId), isNotNull);
    expect(surface.component(SafetyGuardrail.proCalloutId), isNotNull);
  });

  test('builds createSurface and updateComponents messages', () async {
    final turn = await pipeline.process(
      rawResponse([
        stackOf(['diagnosis']),
        diagnosis,
      ]),
      surfacePrefix: 't0',
    );

    final messages = turn.messages(FixitCatalog.id);
    expect(messages.first['createSurface'], {
      'surfaceId': 't0-0',
      'catalogId': FixitCatalog.id,
    });
    expect(messages.last.containsKey('updateComponents'), isTrue);
  });
}
