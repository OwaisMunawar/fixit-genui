import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:flutter/material.dart';

/// A compact, non-interactive pill for metadata such as difficulty, time or
/// confidence.
class InfoChip extends StatelessWidget {
  const InfoChip({
    required this.label,
    this.icon,
    this.tone = Tone.neutral,
    this.semanticLabel,
    super.key,
  });

  final String label;
  final IconData? icon;
  final Tone tone;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = tone.resolve(context);
    final style = Theme.of(context).textTheme.labelMedium?.copyWith(
      color: colors.onContainer,
      fontWeight: FontWeight.w600,
    );
    return Semantics(
      label: semanticLabel,
      excludeSemantics: semanticLabel != null,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.sm + Insets.xxs,
          vertical: Insets.xs,
        ),
        decoration: BoxDecoration(
          color: colors.container,
          borderRadius: BorderRadius.circular(Radii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: colors.onContainer),
              const SizedBox(width: Insets.xs),
            ],
            Flexible(child: Text(label, style: style)),
          ],
        ),
      ),
    );
  }
}
