import 'dart:io';

import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/icon_badge.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:fixit/features/jobs/presentation/widgets/status_chip.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class JobTile extends StatelessWidget {
  const JobTile({
    required this.job,
    required this.onTap,
    this.thumbnail,
    this.selected = false,
    super.key,
  });

  final Job job;
  final File? thumbnail;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final subtitle = [
      l10n.jobUpdatedAt(job.updatedAt),
      if (job.totalSteps > 0)
        l10n.jobStepsProgress(job.completedSteps, job.totalSteps),
    ].join('  ·  ');

    return Card(
      color: selected ? theme.colorScheme.secondaryContainer : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(Radii.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Insets.md),
          child: Row(
            children: [
              _Leading(job: job, thumbnail: thumbnail),
              const SizedBox(width: Insets.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title.isEmpty ? l10n.untitledJob : job.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: Insets.xs),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: Insets.sm),
                    StatusChip(job.status),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading({required this.job, required this.thumbnail});

  final Job job;
  final File? thumbnail;

  @override
  Widget build(BuildContext context) {
    final fallback = IconBadge(
      size: 56,
      icon: switch (job.status) {
        JobStatus.diagnosing => Icons.search_rounded,
        JobStatus.inProgress => Icons.construction_rounded,
        JobStatus.done => Icons.task_alt_rounded,
      },
    );
    final file = thumbnail;
    if (file == null) return fallback;
    return ClipRRect(
      borderRadius: BorderRadius.circular(Radii.md),
      child: Image.file(
        file,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        excludeFromSemantics: true,
        errorBuilder: (_, _, _) => fallback,
      ),
    );
  }
}
