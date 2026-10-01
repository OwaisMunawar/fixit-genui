import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/fixit_card.dart';
import 'package:fixit/core/ui/info_chip.dart';
import 'package:fixit/core/ui/section_header.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/genui/catalog/models/diagnosis_data.dart';
import 'package:fixit/genui/catalog/widgets/bullet_list.dart';
import 'package:fixit/genui/catalog/widgets/catalog_visuals.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class DiagnosisCardView extends StatelessWidget {
  const DiagnosisCardView({required this.data, super.key});

  final DiagnosisData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final percent = (data.confidence.clamp(0, 1) * 100).round();
    final confidenceTone = percent >= 70
        ? Tone.success
        : percent >= 40
        ? Tone.info
        : Tone.warning;

    return FixitCard(
      icon: data.category.icon,
      title: data.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(l10n.likelyCause),
          Text(data.likelyCause, style: theme.textTheme.bodyLarge),
          if (data.summary != null) ...[
            const SizedBox(height: Insets.sm),
            Text(
              data.summary!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: Insets.md),
          Semantics(
            label: l10n.confidenceLabel(percent),
            excludeSemantics: true,
            // Label above the bar rather than beside it, so it never runs
            // out of room at large text sizes.
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.confidenceLabel(percent),
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: Insets.xs),
                ClipRRect(
                  borderRadius: BorderRadius.circular(Insets.xs),
                  child: LinearProgressIndicator(
                    value: percent / 100,
                    minHeight: 6,
                    color: confidenceTone.resolve(context).accent,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Insets.md),
          Wrap(
            spacing: Insets.sm,
            runSpacing: Insets.sm,
            children: [
              InfoChip(
                icon: Icons.build_outlined,
                label: data.difficulty.label(l10n),
                tone: data.difficulty.tone,
              ),
              if (data.estimatedMinutes != null)
                InfoChip(
                  icon: Icons.schedule_rounded,
                  label: l10n.aboutMinutes(data.estimatedMinutes!),
                ),
            ],
          ),
          if (data.alternatives.isNotEmpty) ...[
            const SizedBox(height: Insets.lg),
            SectionHeader(l10n.alsoPossible),
            BulletList(data.alternatives),
          ],
        ],
      ),
    );
  }
}
