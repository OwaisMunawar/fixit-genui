@Tags(['golden'])
library;

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
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/catalog_fixtures.dart';
import '../helpers/pump_app.dart';

/// One golden per catalog widget per brightness, at phone width.
void golden(String name, Widget widget) {
  for (final brightness in Brightness.values) {
    testWidgets('$name (${brightness.name})', (tester) async {
      tester.view.physicalSize = const Size(430 * 2, 1400 * 2);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      const key = ValueKey('golden');

      await tester.pumpWidget(
        testApp(
          Align(
            alignment: Alignment.topCenter,
            child: RepaintBoundary(
              key: key,
              child: Builder(
                builder: (context) => ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(width: 398, child: widget),
                  ),
                ),
              ),
            ),
          ),
          brightness: brightness,
          scroll: false,
        ),
      );
      await tester.pumpAndSettle();

      await expectLater(
        find.byKey(key),
        matchesGoldenFile('goldens/${name}_${brightness.name}.png'),
      );
    });
  }
}

void main() {
  golden(
    'diagnosis_card',
    const DiagnosisCardView(data: CatalogFixtures.diagnosis),
  );
  golden(
    'question_form',
    QuestionFormView(data: CatalogFixtures.questions, onSubmit: (_) {}),
  );
  golden(
    'question_form_answered',
    QuestionFormView(
      data: CatalogFixtures.questions,
      submittedAnswers: const {
        'handles': 'single',
        'where': ['base'],
        'drips': 15,
        'shutoff': true,
      },
      onSubmit: (_) {},
    ),
  );
  golden(
    'step_checklist',
    StepChecklistView(
      data: CatalogFixtures.checklist,
      completed: const {'water'},
      onToggle: (_, {required done}) {},
    ),
  );
  golden('parts_list', const PartsListView(data: CatalogFixtures.parts));
  golden('pro_callout', const ProCalloutView(data: CatalogFixtures.proCallout));
  golden(
    'safety_banner_warning',
    const SafetyBannerView(data: CatalogFixtures.banner),
  );
  golden(
    'safety_banner_danger',
    const SafetyBannerView(
      data: SafetyBannerData(
        severity: SafetySeverity.danger,
        title: 'If you smell gas, leave first',
        message: "Don't switch anything on or off. Get everyone outside.",
        origin: ContentOrigin.guardrail,
      ),
    ),
  );
  golden('note_card', const NoteCardView(data: CatalogFixtures.note));
  golden(
    'note_card_fallback',
    const NoteCardView(
      data: NoteCardData(
        body: 'Dripping kitchen faucet. A worn cartridge.',
        tone: NoteTone.warning,
        origin: ContentOrigin.validator,
      ),
    ),
  );
}
