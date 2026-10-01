import 'package:flutter/material.dart';

/// Semantic colours that Material's [ColorScheme] has no slot for.
///
/// Safety messaging needs a warning colour that reads as "careful" rather than
/// "error", and a success colour for ticked steps, in both brightness modes.
@immutable
class FixitPalette extends ThemeExtension<FixitPalette> {
  const FixitPalette({
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.danger,
    required this.onDanger,
    required this.dangerContainer,
    required this.onDangerContainer,
  });

  static const light = FixitPalette(
    info: Color(0xFF2357A5),
    onInfo: Colors.white,
    infoContainer: Color(0xFFDCE6FA),
    onInfoContainer: Color(0xFF0D2A57),
    success: Color(0xFF2E7D4F),
    onSuccess: Colors.white,
    successContainer: Color(0xFFD6F0DE),
    onSuccessContainer: Color(0xFF0B3A1F),
    warning: Color(0xFF9A5B00),
    onWarning: Colors.white,
    warningContainer: Color(0xFFFFE7C2),
    onWarningContainer: Color(0xFF3D2300),
    danger: Color(0xFFB3261E),
    onDanger: Colors.white,
    dangerContainer: Color(0xFFFFDAD6),
    onDangerContainer: Color(0xFF410002),
  );

  static const dark = FixitPalette(
    info: Color(0xFFAFC6FF),
    onInfo: Color(0xFF0D2A57),
    infoContainer: Color(0xFF1C3766),
    onInfoContainer: Color(0xFFDCE6FA),
    success: Color(0xFF8FD6A6),
    onSuccess: Color(0xFF0B3A1F),
    successContainer: Color(0xFF1D4A2E),
    onSuccessContainer: Color(0xFFD6F0DE),
    warning: Color(0xFFFFC46B),
    onWarning: Color(0xFF3D2300),
    warningContainer: Color(0xFF5A3A07),
    onWarningContainer: Color(0xFFFFE7C2),
    danger: Color(0xFFFFB4AB),
    onDanger: Color(0xFF690005),
    dangerContainer: Color(0xFF7A1C17),
    onDangerContainer: Color(0xFFFFDAD6),
  );

  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color danger;
  final Color onDanger;
  final Color dangerContainer;
  final Color onDangerContainer;

  static FixitPalette of(BuildContext context) =>
      Theme.of(context).extension<FixitPalette>() ??
      (Theme.of(context).brightness == Brightness.dark ? dark : light);

  @override
  FixitPalette copyWith({
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? danger,
    Color? onDanger,
    Color? dangerContainer,
    Color? onDangerContainer,
  }) {
    return FixitPalette(
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      onDangerContainer: onDangerContainer ?? this.onDangerContainer,
    );
  }

  @override
  FixitPalette lerp(FixitPalette? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return FixitPalette(
      info: mix(info, other.info),
      onInfo: mix(onInfo, other.onInfo),
      infoContainer: mix(infoContainer, other.infoContainer),
      onInfoContainer: mix(onInfoContainer, other.onInfoContainer),
      success: mix(success, other.success),
      onSuccess: mix(onSuccess, other.onSuccess),
      successContainer: mix(successContainer, other.successContainer),
      onSuccessContainer: mix(onSuccessContainer, other.onSuccessContainer),
      warning: mix(warning, other.warning),
      onWarning: mix(onWarning, other.onWarning),
      warningContainer: mix(warningContainer, other.warningContainer),
      onWarningContainer: mix(onWarningContainer, other.onWarningContainer),
      danger: mix(danger, other.danger),
      onDanger: mix(onDanger, other.onDanger),
      dangerContainer: mix(dangerContainer, other.dangerContainer),
      onDangerContainer: mix(onDangerContainer, other.onDangerContainer),
    );
  }
}
