import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/guardrails/hazard.dart';
import 'package:fixit/genui/guardrails/safety_guardrail.dart';
import 'package:fixit/genui/pipeline/surface_draft.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/responses.dart';

TurnDraft turnOf(List<Map<String, Object?>> components) => TurnDraft(
  surfaces: [SurfaceDraft(surfaceId: 's', components: components)],
);

List<String> childrenOf(TurnDraft turn) =>
    (turn.surfaces.single.root!['children']! as List).cast<String>();

void main() {
  const guardrail = SafetyGuardrail();
  const electrical = HazardAssessment({Hazard.electrical});

  test('does nothing for a job with no hazard', () {
    final turn = turnOf([
      stackOf(['diagnosis']),
      diagnosis,
    ]);

    final (guarded, report) = guardrail.enforce(turn, HazardAssessment.none);

    expect(identical(guarded, turn), isTrue);
    expect(report.intervened, isFalse);
  });

  test('injects a banner first and a pro callout last', () {
    final (guarded, report) = guardrail.enforce(
      turnOf([
        stackOf(['diagnosis', 'checklist']),
        electricalDiagnosis,
        checklist,
      ]),
      electrical,
    );

    expect(childrenOf(guarded), [
      SafetyGuardrail.bannerId,
      'diagnosis',
      'checklist',
      SafetyGuardrail.proCalloutId,
    ]);
    final banner = guarded.surfaces.single.component(SafetyGuardrail.bannerId)!;
    expect(banner['severity'], 'warning');
    expect(banner['origin'], 'guardrail');
    expect(
      report.actions,
      containsAll([
        GuardrailAction.injectedSafetyBanner,
        GuardrailAction.injectedProCallout,
      ]),
    );
  });

  test("keeps the model's own banner and callout", () {
    final (guarded, report) = guardrail.enforce(
      turnOf([
        stackOf(['banner', 'pro']),
        {
          'id': 'banner',
          'component': CatalogNames.safetyBanner,
          'severity': 'danger',
          'title': 'Stop',
          'message': 'Turn it off.',
        },
        {
          'id': 'pro',
          'component': CatalogNames.proCallout,
          'title': 'Call',
          'reasons': ['Because'],
          'costLow': 1,
          'costHigh': 2,
        },
      ]),
      electrical,
    );

    expect(childrenOf(guarded), ['banner', 'pro']);
    expect(report.intervened, isFalse);
  });

  test('upgrades a banner weaker than the hazard demands', () {
    final (guarded, report) = guardrail.enforce(
      turnOf([
        stackOf(['banner']),
        {
          'id': 'banner',
          'component': CatalogNames.safetyBanner,
          'severity': 'caution',
          'title': 'Careful',
          'message': 'Mind the gas.',
        },
      ]),
      const HazardAssessment({Hazard.gas}),
    );

    expect(guarded.surfaces.single.component('banner')!['severity'], 'danger');
    expect(report.actions, contains(GuardrailAction.upgradedSeverity));
  });

  test('moves an existing banner to the top', () {
    final (guarded, report) = guardrail.enforce(
      turnOf([
        stackOf(['diagnosis', 'banner']),
        electricalDiagnosis,
        {
          'id': 'banner',
          'component': CatalogNames.safetyBanner,
          'severity': 'warning',
          'title': 'Careful',
          'message': 'Breaker off first.',
        },
      ]),
      electrical,
    );

    expect(childrenOf(guarded).first, 'banner');
    expect(report.actions, contains(GuardrailAction.movedBannerFirst));
  });

  test('wraps a single-widget answer so safety content can be added', () {
    final (guarded, report) = guardrail.enforce(
      turnOf([
        {...electricalDiagnosis, 'id': 'root'},
      ]),
      electrical,
    );

    final surface = guarded.surfaces.single;
    expect(surface.root!['component'], CatalogNames.responseStack);
    expect(surface.component('root_content')!['component'], 'DiagnosisCard');
    expect(childrenOf(guarded), [
      SafetyGuardrail.bannerId,
      'root_content',
      SafetyGuardrail.proCalloutId,
    ]);
    expect(report.actions, contains(GuardrailAction.wrappedRoot));
  });

  test('uses hazard-specific copy for every hazard', () {
    for (final hazard in Hazard.values) {
      final (guarded, _) = guardrail.enforce(
        turnOf([
          stackOf(['diagnosis']),
          diagnosis,
        ]),
        HazardAssessment({hazard}),
      );
      final surface = guarded.surfaces.single;
      expect(
        surface.component(SafetyGuardrail.bannerId)!['severity'],
        hazard.minimumSeverity.name,
      );
      expect(
        surface.component(SafetyGuardrail.proCalloutId)!['trade'],
        isNotEmpty,
      );
    }
  });

  test('reads diagnosed categories for the next assessment', () {
    final categories = SafetyGuardrail.diagnosedCategories(
      turnOf([
        stackOf(['diagnosis']),
        electricalDiagnosis,
      ]),
    );

    expect(categories, [RepairCategory.electrical]);
  });
}
