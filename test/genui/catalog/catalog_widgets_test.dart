import 'package:fixit/genui/catalog/models/note_card_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/catalog/models/safety_banner_data.dart';
import 'package:fixit/genui/catalog/widgets/diagnosis_card_view.dart';
import 'package:fixit/genui/catalog/widgets/note_card_view.dart';
import 'package:fixit/genui/catalog/widgets/parts_list_view.dart';
import 'package:fixit/genui/catalog/widgets/pro_callout_view.dart';
import 'package:fixit/genui/catalog/widgets/question_form_view.dart';
import 'package:fixit/genui/catalog/widgets/safety_banner_view.dart';
import 'package:fixit/genui/catalog/widgets/step_checklist_view.dart';
import 'package:fixit/l10n/gen/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/catalog_fixtures.dart';
import '../../helpers/pump_app.dart';

void main() {
  final l10n = AppLocalizationsEn();

  group('DiagnosisCardView', () {
    testWidgets('shows cause, confidence, difficulty and alternatives', (
      tester,
    ) async {
      await tester.pumpApp(
        const DiagnosisCardView(data: CatalogFixtures.diagnosis),
      );

      expect(find.text('Dripping kitchen faucet'), findsOneWidget);
      expect(find.text(CatalogFixtures.diagnosis.likelyCause), findsOneWidget);
      expect(find.text(l10n.confidenceLabel(78)), findsOneWidget);
      expect(find.text(l10n.difficultyEasy), findsOneWidget);
      expect(find.text(l10n.aboutMinutes(45)), findsOneWidget);
      expect(find.text('Mineral build-up on the valve seat'), findsOneWidget);
    });

    testWidgets('a low-confidence pro job reads accordingly', (tester) async {
      await tester.pumpApp(
        DiagnosisCardView(
          data: CatalogFixtures.diagnosis.copyWith(
            confidence: 0.2,
            difficulty: Difficulty.pro,
            estimatedMinutes: null,
            alternatives: const [],
            summary: null,
          ),
        ),
      );

      expect(find.text(l10n.confidenceLabel(20)), findsOneWidget);
      expect(find.text(l10n.difficultyPro), findsOneWidget);
      expect(find.text(l10n.alsoPossible.toUpperCase()), findsNothing);
    });
  });

  group('QuestionFormView', () {
    testWidgets('submits once every required question is answered', (
      tester,
    ) async {
      QuestionFormSubmission? submitted;
      await tester.pumpApp(
        QuestionFormView(
          data: CatalogFixtures.questions,
          onSubmit: (s) => submitted = s,
        ),
      );

      final submit = find.widgetWithText(FilledButton, 'Get my fix plan');
      expect(tester.widget<FilledButton>(submit).onPressed, isNull);

      for (final label in ['One lever', 'Spout', 'Base', 'Base', l10n.no]) {
        await tester.tap(find.text(label));
        await tester.pump();
      }

      await tester.ensureVisible(submit);
      await tester.tap(submit);

      expect(submitted!.answers, {
        'handles': 'single',
        'where': ['spout'],
        'drips': 30,
        'shutoff': false,
      });
      expect(submitted!.summary, [
        'How many handles? One lever',
        'Where does it leak? Spout',
        'Drips a minute 30 a min',
        'Shut-off valves? No',
      ]);
      expect(submitted!.toJson()['answers'], submitted!.answers);
    });

    testWidgets('dragging the slider changes its answer', (tester) async {
      QuestionFormSubmission? submitted;
      await tester.pumpApp(
        QuestionFormView(
          data: CatalogFixtures.questions.copyWith(
            questions: [CatalogFixtures.questions.questions[2]],
          ),
          onSubmit: (s) => submitted = s,
        ),
      );

      await tester.drag(find.byType(Slider), const Offset(-400, 0));
      await tester.pump();
      await tester.tap(find.text('Get my fix plan'));

      expect(submitted!.answers['drips'], 0);
    });

    testWidgets('renders read-only once answered', (tester) async {
      await tester.pumpApp(
        QuestionFormView(
          data: CatalogFixtures.questions,
          submittedAnswers: const {'handles': 'double', 'shutoff': true},
          onSubmit: (_) => fail('must not submit twice'),
        ),
      );

      expect(find.text(l10n.answered), findsOneWidget);
      expect(find.text('Get my fix plan'), findsNothing);
      final chip = tester.widget<ChoiceChip>(
        find.widgetWithText(ChoiceChip, 'Two handles'),
      );
      expect(chip.selected, isTrue);
      expect(chip.onSelected, isNull);
    });
  });

  group('StepChecklistView', () {
    testWidgets('ticks steps and shows progress and safety', (tester) async {
      final toggled = <(String, bool)>[];
      await tester.pumpApp(
        StepChecklistView(
          data: CatalogFixtures.checklist,
          completed: const {'water'},
          onToggle: (id, {required done}) => toggled.add((id, done)),
        ),
      );

      expect(find.text('1/3'), findsOneWidget);
      expect(find.text(l10n.aboutMinutes(17)), findsOneWidget);
      expect(
        find.textContaining('Wear eye protection', findRichText: true),
        findsOneWidget,
      );

      await tester.tap(find.text('2. Remove the handle'));
      await tester.tap(find.byType(Checkbox).first);
      expect(toggled, [('handle', true), ('water', false)]);
    });

    testWidgets('celebrates a finished list', (tester) async {
      await tester.pumpApp(
        StepChecklistView(
          data: CatalogFixtures.checklist,
          completed: const {'water', 'handle', 'cartridge'},
          onToggle: (_, {required done}) {},
        ),
      );

      expect(find.byIcon(Icons.task_alt_rounded), findsOneWidget);
    });
  });

  testWidgets('PartsListView totals client-side and lists tools', (
    tester,
  ) async {
    await tester.pumpApp(const PartsListView(data: CatalogFixtures.parts));

    expect(find.text(l10n.partsTitle), findsOneWidget);
    expect(find.text(l10n.quantity(3)), findsOneWidget);
    expect(find.text(r'$4.50'), findsOneWidget);
    expect(find.text(r'$28.50'), findsOneWidget);
    expect(find.text('Allen key'), findsOneWidget);
  });

  testWidgets('ProCalloutView shows the range and its origin', (tester) async {
    await tester.pumpApp(
      ProCalloutView(
        data: CatalogFixtures.proCallout.copyWith(costLow: 400, costHigh: 150),
      ),
    );

    expect(find.text(r'$150 to $400'), findsOneWidget);
    expect(find.text('Licensed electrician'), findsOneWidget);
    expect(find.text(l10n.addedBySafetyCheck), findsOneWidget);
  });

  group('SafetyBannerView', () {
    for (final severity in SafetySeverity.values) {
      testWidgets('renders ${severity.name}', (tester) async {
        await tester.pumpApp(
          SafetyBannerView(
            data: CatalogFixtures.banner.copyWith(severity: severity),
          ),
        );
        expect(find.text('Treat the circuit as live'), findsOneWidget);
        expect(find.text(l10n.addedBySafetyCheck), findsNothing);
      });
    }

    testWidgets('is announced to assistive technology', (tester) async {
      await tester.pumpApp(
        const SafetyBannerView(
          data: SafetyBannerData(
            severity: SafetySeverity.danger,
            title: 'Leave the house',
            message: 'Gas smell.',
          ),
        ),
      );
      final semantics = tester.getSemantics(
        find.byType(SafetyBannerView),
      );
      expect(semantics.flagsCollection.isLiveRegion, isTrue);
    });
  });

  group('NoteCardView', () {
    testWidgets('shows the model note', (tester) async {
      await tester.pumpApp(const NoteCardView(data: CatalogFixtures.note));
      expect(find.text('Good news'), findsOneWidget);
    });

    testWidgets('fallback notes use the fallback title', (tester) async {
      await tester.pumpApp(
        const NoteCardView(
          data: NoteCardData(
            body: 'Partial text',
            tone: NoteTone.warning,
            origin: ContentOrigin.validator,
          ),
        ),
      );
      expect(find.text(l10n.fallbackTitle), findsOneWidget);
      expect(find.text('Partial text'), findsOneWidget);
    });
  });

  testWidgets('every catalog widget stays usable at 2x text', (tester) async {
    tester.view.physicalSize = const Size(390 * 3, 2400 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await tester.pumpApp(
      MediaQuery(
        data: const MediaQueryData(textScaler: TextScaler.linear(2)),
        child: Column(
          children: [
            const DiagnosisCardView(data: CatalogFixtures.diagnosis),
            StepChecklistView(
              data: CatalogFixtures.checklist,
              completed: const {},
              onToggle: (_, {required done}) {},
            ),
            const PartsListView(data: CatalogFixtures.parts),
            const ProCalloutView(data: CatalogFixtures.proCallout),
            const SafetyBannerView(data: CatalogFixtures.banner),
          ],
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });
}
