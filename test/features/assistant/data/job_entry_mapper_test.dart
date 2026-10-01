import 'dart:typed_data';

import 'package:fixit/features/assistant/data/job_entry_mapper.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/pipeline/turn_pipeline.dart';
import 'package:fixit/genui/session/completed_turn.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fakes.dart';
import '../../../helpers/responses.dart';

void main() {
  final photos = MemoryPhotoStore();
  final mapper = JobEntryMapper(photos);
  final pipeline = TurnPipeline(catalog: FixitCatalog.catalog);

  Future<CompletedTurn> turnFor(TurnInput input, String raw) async {
    final processed = await pipeline.process(raw, surfacePrefix: 't1');
    return CompletedTurn(
      index: 1,
      input: input,
      rawResponse: raw,
      processed: processed,
      messages: processed.messages(FixitCatalog.id),
    );
  }

  test('an answered turn stores the answers, then the model reply', () async {
    final turn = await turnFor(
      const AnswersInput(
        surfaceId: 't0-0',
        componentId: 'questions',
        formTitle: 'Q',
        answers: {'a': true},
        summary: ['A? Yes'],
      ),
      rawResponse([
        stackOf(['diagnosis', 'checklist']),
        electricalDiagnosis,
        checklist,
      ]),
    );

    final entries = mapper.entriesFor(turn, at: DateTime(2026));

    expect(entries.first, isA<AnswersEntry>());
    final model = entries.last as ModelEntry;
    expect(model.surfaceIds, ['t1-0']);
    expect(model.checklists.single.stepIds, ['a', 'b']);
    expect(model.categories, ['electrical']);
  });

  test('rebuilds a session snapshot from stored history', () async {
    final path = await photos.save('job', Uint8List.fromList([9]));
    final entries = [
      JobEntry.user(text: 'Breaker', imagePath: path, createdAt: DateTime(1)),
      JobEntry.model(
        rawResponse: 'raw-1',
        text: '',
        surfaceIds: const ['t0-0'],
        messages: const [
          {'version': 'v0.9'},
        ],
        categories: const ['electrical', 'not-a-category'],
        createdAt: DateTime(2),
      ),
      JobEntry.answers(
        surfaceId: 't0-0',
        componentId: 'questions',
        formTitle: 'Q',
        answers: const {'smell': false},
        summary: const ['Smell? No'],
        createdAt: DateTime(3),
      ),
      JobEntry.user(
        text: 'gone',
        imagePath: 'jobs/job/missing.jpg',
        createdAt: DateTime(4),
      ),
    ];

    final snapshot = await mapper.snapshotFor(entries, {
      (surfaceId: 't1-0', componentId: 'checklist'): {'a'},
    });

    expect(snapshot.turnCount, 1);
    expect(snapshot.userTexts, ['Breaker', 'gone']);
    expect(snapshot.categories, {RepairCategory.electrical});
    expect(snapshot.history.map((t) => t.role), [
      RepairRole.user,
      RepairRole.model,
      RepairRole.user,
      RepairRole.user,
    ]);
    expect(snapshot.history.first.image!.bytes, [9]);
    expect(snapshot.history.last.image, isNull);
    expect(snapshot.history[2].text, contains('Smell? No'));
    expect(snapshot.formAnswers.single.answers, {'smell': false});
    expect(snapshot.checklists.single.completed, {'a'});
    expect(snapshot.messages, hasLength(1));
  });
}
