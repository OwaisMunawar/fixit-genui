import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

@immutable
final class SampleProblem {
  const SampleProblem({
    required this.icon,
    required this.label,
    required this.prompt,
  });

  final IconData icon;
  final String label;
  final String prompt;

  /// The three problems demo mode has scripts for. They also make a good
  /// first prompt with Gemini.
  static List<SampleProblem> all(AppLocalizations l10n) => [
    SampleProblem(
      icon: Icons.water_drop_outlined,
      label: l10n.sampleLeakyFaucet,
      prompt: l10n.sampleLeakyFaucetPrompt,
    ),
    SampleProblem(
      icon: Icons.electric_bolt_outlined,
      label: l10n.sampleTrippedBreaker,
      prompt: l10n.sampleTrippedBreakerPrompt,
    ),
    SampleProblem(
      icon: Icons.grid_view_rounded,
      label: l10n.sampleCrackedTile,
      prompt: l10n.sampleCrackedTilePrompt,
    ),
  ];
}
