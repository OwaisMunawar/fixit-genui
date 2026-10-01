import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

/// Icon, tone and label mappings shared by catalog widgets, so a category or
/// severity looks the same wherever it appears.
extension RepairCategoryVisuals on RepairCategory {
  IconData get icon => switch (this) {
    RepairCategory.plumbing => Icons.plumbing,
    RepairCategory.electrical => Icons.electrical_services,
    RepairCategory.gas => Icons.local_fire_department,
    RepairCategory.structural => Icons.foundation,
    RepairCategory.flooring => Icons.grid_view_rounded,
    RepairCategory.carpentry => Icons.carpenter,
    RepairCategory.appliance => Icons.kitchen,
    RepairCategory.hvac => Icons.hvac,
    RepairCategory.roofing => Icons.roofing,
    RepairCategory.general => Icons.handyman,
  };
}

extension DifficultyVisuals on Difficulty {
  Tone get tone => switch (this) {
    Difficulty.easy => Tone.success,
    Difficulty.moderate => Tone.info,
    Difficulty.hard => Tone.warning,
    Difficulty.pro => Tone.danger,
  };

  String label(AppLocalizations l10n) => switch (this) {
    Difficulty.easy => l10n.difficultyEasy,
    Difficulty.moderate => l10n.difficultyModerate,
    Difficulty.hard => l10n.difficultyHard,
    Difficulty.pro => l10n.difficultyPro,
  };
}

extension SafetySeverityVisuals on SafetySeverity {
  Tone get tone => switch (this) {
    SafetySeverity.caution => Tone.info,
    SafetySeverity.warning => Tone.warning,
    SafetySeverity.danger => Tone.danger,
  };

  IconData get icon => switch (this) {
    SafetySeverity.caution => Icons.info_outline_rounded,
    SafetySeverity.warning => Icons.warning_amber_rounded,
    SafetySeverity.danger => Icons.dangerous_outlined,
  };
}
