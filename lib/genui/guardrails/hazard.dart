import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:flutter/foundation.dart';

/// Problems that must never be answered as plain DIY.
///
/// Declared in priority order: when a job touches more than one, the banner
/// speaks to the first.
enum Hazard {
  gas(SafetySeverity.danger),
  electrical(SafetySeverity.warning),
  structural(SafetySeverity.warning);

  const Hazard(this.minimumSeverity);

  /// The weakest banner the guardrail will accept for this hazard. A model
  /// that calls a gas smell a "caution" gets upgraded.
  final SafetySeverity minimumSeverity;

  static Hazard? fromCategory(RepairCategory category) => switch (category) {
    RepairCategory.gas => Hazard.gas,
    RepairCategory.electrical => Hazard.electrical,
    RepairCategory.structural => Hazard.structural,
    _ => null,
  };
}

@immutable
final class HazardAssessment {
  const HazardAssessment(this.hazards);

  static const none = HazardAssessment({});

  final Set<Hazard> hazards;

  bool get isHazardous => hazards.isNotEmpty;

  Hazard? get primary => Hazard.values.where(hazards.contains).firstOrNull;

  SafetySeverity get minimumSeverity => hazards
      .map((h) => h.minimumSeverity)
      .fold(
        SafetySeverity.caution,
        (worst, s) => s.isAtLeast(worst) ? s : worst,
      );
}
