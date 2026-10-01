import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/icon_badge.dart';
import 'package:fixit/core/ui/section_header.dart';
import 'package:fixit/features/assistant/presentation/sample_problems.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class NewJobIntro extends StatelessWidget {
  const NewJobIntro({required this.onSample, super.key});

  final ValueChanged<SampleProblem> onSample;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(Insets.lg),
      children: [
        const SizedBox(height: Insets.xl),
        const Center(child: IconBadge(icon: Icons.handyman_outlined, size: 64)),
        const SizedBox(height: Insets.lg),
        Text(
          l10n.newJobIntro,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: Insets.xxl),
        SectionHeader(l10n.samplesTitle),
        const SizedBox(height: Insets.xs),
        for (final sample in SampleProblem.all(l10n))
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.sm),
            child: Card(
              child: ListTile(
                leading: Icon(sample.icon, color: theme.colorScheme.primary),
                title: Text(sample.label),
                subtitle: Text(sample.prompt),
                trailing: const Icon(Icons.arrow_forward_rounded),
                onTap: () => onSample(sample),
              ),
            ),
          ),
      ],
    );
  }
}
