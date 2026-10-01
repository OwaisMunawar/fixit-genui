import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/guardrails/hazard.dart';
import 'package:fixit/genui/guardrails/safety_templates.dart';
import 'package:fixit/genui/pipeline/surface_draft.dart';
import 'package:flutter/foundation.dart';

enum GuardrailAction {
  injectedSafetyBanner,
  injectedProCallout,
  upgradedSeverity,
  movedBannerFirst,
  wrappedRoot,
}

@immutable
final class GuardrailReport {
  const GuardrailReport({required this.assessment, required this.actions});

  final HazardAssessment assessment;
  final List<GuardrailAction> actions;

  bool get intervened => actions.isNotEmpty;
}

/// Post-check that runs on every validated turn, after the model has answered
/// and before anything renders.
///
/// The system prompt asks the model to include a SafetyBanner and ProCallout
/// for hazardous jobs. Prompts are requests, not guarantees, so this enforces
/// it: every surface of a hazardous job leaves here with a banner first, a
/// pro callout present, and a severity no weaker than the hazard demands.
final class SafetyGuardrail {
  const SafetyGuardrail();

  static const bannerId = 'guardrail_safety';
  static const proCalloutId = 'guardrail_pro';
  static const _wrappedRootId = 'root_content';

  (TurnDraft, GuardrailReport) enforce(
    TurnDraft turn,
    HazardAssessment assessment,
  ) {
    final hazard = assessment.primary;
    if (hazard == null) {
      return (turn, GuardrailReport(assessment: assessment, actions: const []));
    }
    final actions = <GuardrailAction>[];
    final surfaces = [
      for (final surface in turn.surfaces)
        _enforceSurface(surface, hazard, assessment.minimumSeverity, actions),
    ];
    return (
      turn.copyWith(surfaces: surfaces),
      GuardrailReport(assessment: assessment, actions: actions),
    );
  }

  SurfaceDraft _enforceSurface(
    SurfaceDraft surface,
    Hazard hazard,
    SafetySeverity minimum,
    List<GuardrailAction> actions,
  ) {
    var components = [...surface.components];

    var root = components.firstWhere((c) => c['id'] == SurfaceDraft.rootId);
    if (root['component'] != CatalogNames.responseStack) {
      // A single-widget answer: move it under a stack so there is somewhere
      // to put the banner and callout.
      actions.add(GuardrailAction.wrappedRoot);
      components = [
        for (final c in components)
          if (identical(c, root)) {...c, 'id': _wrappedRootId} else c,
      ];
      root = {
        'id': SurfaceDraft.rootId,
        'component': CatalogNames.responseStack,
        'children': [_wrappedRootId],
      };
      components.insert(0, root);
    }

    final children = [...(root['children']! as List).cast<String>()];

    final bannerIndex = components.indexWhere(
      (c) => c['component'] == CatalogNames.safetyBanner,
    );
    if (bannerIndex == -1) {
      final copy = SafetyTemplates.banner(hazard);
      components.add({
        'id': bannerId,
        'component': CatalogNames.safetyBanner,
        'severity': minimum.name,
        'title': copy.title,
        'message': copy.message,
        'origin': ContentOrigin.guardrail.name,
      });
      children.insert(0, bannerId);
      actions.add(GuardrailAction.injectedSafetyBanner);
    } else {
      final banner = components[bannerIndex];
      final severity = SafetySeverity.values.asNameMap()[banner['severity']];
      if (severity == null || !severity.isAtLeast(minimum)) {
        components[bannerIndex] = {...banner, 'severity': minimum.name};
        actions.add(GuardrailAction.upgradedSeverity);
      }
      final id = banner['id']! as String;
      if (children.isNotEmpty && children.first != id) {
        children
          ..remove(id)
          ..insert(0, id);
        actions.add(GuardrailAction.movedBannerFirst);
      }
    }

    if (!components.any((c) => c['component'] == CatalogNames.proCallout)) {
      final copy = SafetyTemplates.proCallout(hazard);
      components.add({
        'id': proCalloutId,
        'component': CatalogNames.proCallout,
        'title': copy.title,
        'trade': copy.trade,
        'reasons': copy.reasons,
        'costLow': copy.costLow,
        'costHigh': copy.costHigh,
        'currency': 'USD',
        'origin': ContentOrigin.guardrail.name,
      });
      children.add(proCalloutId);
      actions.add(GuardrailAction.injectedProCallout);
    }

    final rootIndex = components.indexWhere(
      (c) => c['id'] == SurfaceDraft.rootId,
    );
    components[rootIndex] = {...components[rootIndex], 'children': children};
    return surface.copyWith(components: components);
  }

  /// Categories the model assigned in this turn, which feed the next
  /// assessment.
  static Iterable<RepairCategory> diagnosedCategories(TurnDraft turn) => turn
      .allComponents
      .where((c) => c['component'] == CatalogNames.diagnosisCard)
      .map((c) => RepairCategory.values.asNameMap()[c['category']])
      .nonNulls;
}
