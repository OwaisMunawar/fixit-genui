import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/session/completed_turn.dart';
import 'package:fixit/genui/session/genui_session.dart';
import 'package:fixit/l10n/gen/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';

import '../../helpers/fakes.dart';
import '../../helpers/pump_app.dart';
import '../../helpers/responses.dart';

void main() {
  final l10n = AppLocalizationsEn();
  late QueuedGenerator generator;
  late List<CompletedTurn> committed;
  late GenUiSession session;
  late List<ChatMessage> genuiReports;

  setUp(() {
    generator = QueuedGenerator();
    committed = [];
    genuiReports = [];
    session = GenUiSession(
      generator: generator,
      onCommit: (turn) async => committed.add(turn),
    );
    session.controller.onSubmit.listen(genuiReports.add);
  });

  tearDown(() => session.dispose());

  Widget surfaces() => Column(
    children: [
      for (final id in session.controller.activeSurfaceIds)
        Surface(surfaceContext: session.surfaceContext(id)),
    ],
  );

  testWidgets('invalid model output degrades to a fallback card', (
    tester,
  ) async {
    generator.enqueue(
      rawResponse([
        stackOf(['diagnosis', 'checklist']),
        {...diagnosis, 'confidence': 'very'},
        checklist,
      ]),
    );

    await tester.runAsync(() => session.send(const TextInput(text: 'drip')));
    await tester.pumpApp(surfaces());

    expect(find.text(l10n.fallbackTitle), findsOneWidget);
    expect(find.textContaining('Dripping faucet'), findsOneWidget);
    expect(find.text('Fix it'), findsOneWidget, reason: 'siblings survive');

    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    expect(
      genuiReports,
      isEmpty,
      reason: "the repaired surface passes genui's own validation",
    );
  });

  testWidgets('submitted answers flow back to the generator', (tester) async {
    generator
      ..enqueue(
        rawResponse([
          stackOf(['questions']),
          {
            'id': 'questions',
            'component': 'QuestionForm',
            'title': 'Quick check',
            'questions': [
              {'id': 'shutoff', 'label': 'Shut-off valve?', 'type': 'yesNo'},
            ],
          },
        ]),
      )
      ..enqueue(rawResponse([checklist]));

    await tester.runAsync(() => session.send(const TextInput(text: 'drip')));
    await tester.pumpApp(surfaces());

    await tester.tap(find.text(l10n.yes));
    await tester.pump();
    await tester.tap(find.text(l10n.submitAnswers));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();

    final answers = generator.requests.last.input as AnswersInput;
    expect(answers.answers, {'shutoff': true});
    expect(answers.summary, ['Shut-off valve? Yes']);
    expect(find.text(l10n.answered), findsOneWidget);
  });

  testWidgets('restore replays surfaces and widget state', (tester) async {
    generator.enqueue(rawResponse([checklist]));
    await tester.runAsync(() => session.send(const TextInput(text: 'go')));
    final turn = committed.single;

    final restored = GenUiSession(
      generator: QueuedGenerator(),
      onCommit: (_) async {},
    );
    addTearDown(restored.dispose);
    restored.restore(
      SessionSnapshot(
        history: const [],
        userTexts: const ['go'],
        categories: const {},
        turnCount: 1,
        messages: turn.messages,
        checklists: [
          ChecklistState(
            surfaceId: turn.processed.surfaceIds.single,
            componentId: 'checklist',
            completed: const {'a'},
          ),
          const ChecklistState(
            surfaceId: 'gone',
            componentId: 'x',
            completed: {'a'},
          ),
        ],
      ),
    );

    await tester.pumpApp(
      Surface(
        surfaceContext: restored.surfaceContext(
          turn.processed.surfaceIds.single,
        ),
      ),
    );

    expect(find.text('1/2'), findsOneWidget);
    expect(restored.transport.turnCount, 1);
  });

  test('retry is a no-op when nothing failed', () async {
    await session.retry();
    expect(generator.requests, isEmpty);
    expect(session.lastFailedInput, isNull);
    expect(CatalogNames.submitAnswersAction, 'submitAnswers');
  });
}
