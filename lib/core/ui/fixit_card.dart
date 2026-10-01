import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/icon_badge.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:flutter/material.dart';

/// The shell every generated widget sits in: a header with an icon badge,
/// title and optional trailing widget, then the body.
///
/// Keeping one shell means a model-generated answer reads as one product no
/// matter which mix of catalog items the model picked.
class FixitCard extends StatelessWidget {
  const FixitCard({
    required this.child,
    this.title,
    this.icon,
    this.subtitle,
    this.trailing,
    this.tone = Tone.brand,
    this.filled = false,
    this.footer,
    super.key,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final Widget child;
  final Widget? footer;
  final Tone tone;

  /// Filled cards use the tone's container colour as the background. Safety
  /// messaging uses this so it cannot be skimmed past.
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = tone.resolve(context);
    final onColor = filled ? colors.onContainer : theme.colorScheme.onSurface;

    return Card(
      color: filled ? colors.container : null,
      shape: filled
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.lg),
              side: BorderSide(color: colors.accent.withValues(alpha: 0.4)),
            )
          : null,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(Insets.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (icon != null) ...[
                  IconBadge(icon: icon!, tone: tone),
                  const SizedBox(width: Insets.md),
                ],
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: onColor,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: Insets.xxs),
                          Text(
                            subtitle!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: filled
                                  ? colors.onContainer
                                  : theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (trailing != null) ...[
                  const SizedBox(width: Insets.sm),
                  trailing!,
                ],
              ],
            ),
            const SizedBox(height: Insets.md),
            DefaultTextStyle.merge(
              style: TextStyle(color: onColor),
              child: child,
            ),
            if (footer != null) ...[
              const SizedBox(height: Insets.md),
              footer!,
            ],
          ],
        ),
      ),
    );
  }
}
