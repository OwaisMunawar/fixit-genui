import 'package:fixit/core/theme/fixit_palette.dart';
import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/fixit_card.dart';
import 'package:fixit/core/ui/info_chip.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/genui/catalog/models/step_checklist_data.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class StepChecklistView extends StatelessWidget {
  const StepChecklistView({
    required this.data,
    required this.completed,
    required this.onToggle,
    super.key,
  });

  final StepChecklistData data;
  final Set<String> completed;
  final void Function(String stepId, {required bool done}) onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final total = data.steps.length;
    final done = data.steps.where((s) => completed.contains(s.id)).length;
    final minutes = data.totalMinutes;
    final allDone = total > 0 && done == total;

    return FixitCard(
      icon: allDone ? Icons.task_alt_rounded : Icons.checklist_rounded,
      tone: allDone ? Tone.success : Tone.brand,
      title: data.title,
      subtitle: minutes == null ? null : l10n.aboutMinutes(minutes),
      trailing: InfoChip(
        label: '$done/$total',
        tone: allDone ? Tone.success : Tone.neutral,
        semanticLabel: l10n.checklistProgress(done, total),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExcludeSemantics(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Insets.xs),
              child: LinearProgressIndicator(
                value: total == 0 ? 0 : done / total,
                minHeight: 6,
                color: allDone
                    ? FixitPalette.of(context).success
                    : theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              ),
            ),
          ),
          const SizedBox(height: Insets.sm),
          for (final (index, step) in data.steps.indexed)
            _StepRow(
              number: index + 1,
              step: step,
              done: completed.contains(step.id),
              onChanged: (value) => onToggle(step.id, done: value),
            ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.number,
    required this.step,
    required this.done,
    required this.onChanged,
  });

  final int number;
  final ChecklistStep step;
  final bool done;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final palette = FixitPalette.of(context);
    final titleStyle = theme.textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w600,
      decoration: done ? TextDecoration.lineThrough : null,
      color: done
          ? theme.colorScheme.onSurfaceVariant
          : theme.colorScheme.onSurface,
    );

    return MergeSemantics(
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.md),
        onTap: () => onChanged(!done),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Insets.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: done,
                onChanged: (value) => onChanged(value ?? false),
                semanticLabel: '${l10n.stepDone} $number',
              ),
              const SizedBox(width: Insets.xs),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: Insets.md - 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$number. ${step.title}', style: titleStyle),
                      if (step.detail != null) ...[
                        const SizedBox(height: Insets.xxs),
                        Text(
                          step.detail!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                      if (step.minutes != null) ...[
                        const SizedBox(height: Insets.sm),
                        InfoChip(
                          icon: Icons.schedule_rounded,
                          label: l10n.minutesShort(step.minutes!),
                        ),
                      ],
                      if (step.safety != null) ...[
                        const SizedBox(height: Insets.sm),
                        _SafetyCallout(
                          label: l10n.safety,
                          text: step.safety!,
                          background: palette.warningContainer,
                          foreground: palette.onWarningContainer,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SafetyCallout extends StatelessWidget {
  const _SafetyCallout({
    required this.label,
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String label;
  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(Insets.sm + Insets.xxs),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(Radii.sm),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, size: 18, color: foreground),
          const SizedBox(width: Insets.sm),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: text),
                ],
              ),
              style: theme.textTheme.bodySmall?.copyWith(color: foreground),
            ),
          ),
        ],
      ),
    );
  }
}
