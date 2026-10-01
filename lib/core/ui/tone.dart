import 'package:fixit/core/theme/fixit_palette.dart';
import 'package:flutter/material.dart';

/// The emotional register of a piece of UI. Catalog widgets pick a tone and
/// the primitives turn it into colours, so no widget hard-codes a colour.
enum Tone { neutral, brand, info, success, warning, danger }

@immutable
class ToneColors {
  const ToneColors({
    required this.accent,
    required this.onAccent,
    required this.container,
    required this.onContainer,
  });

  final Color accent;
  final Color onAccent;
  final Color container;
  final Color onContainer;
}

extension ToneResolver on Tone {
  ToneColors resolve(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = FixitPalette.of(context);
    return switch (this) {
      Tone.neutral => ToneColors(
        accent: scheme.onSurfaceVariant,
        onAccent: scheme.surface,
        container: scheme.surfaceContainerHighest,
        onContainer: scheme.onSurface,
      ),
      Tone.brand => ToneColors(
        accent: scheme.primary,
        onAccent: scheme.onPrimary,
        container: scheme.primaryContainer,
        onContainer: scheme.onPrimaryContainer,
      ),
      Tone.info => ToneColors(
        accent: palette.info,
        onAccent: palette.onInfo,
        container: palette.infoContainer,
        onContainer: palette.onInfoContainer,
      ),
      Tone.success => ToneColors(
        accent: palette.success,
        onAccent: palette.onSuccess,
        container: palette.successContainer,
        onContainer: palette.onSuccessContainer,
      ),
      Tone.warning => ToneColors(
        accent: palette.warning,
        onAccent: palette.onWarning,
        container: palette.warningContainer,
        onContainer: palette.onWarningContainer,
      ),
      Tone.danger => ToneColors(
        accent: palette.danger,
        onAccent: palette.onDanger,
        container: palette.dangerContainer,
        onContainer: palette.onDangerContainer,
      ),
    };
  }
}
