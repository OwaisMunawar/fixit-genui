import 'dart:async';
import 'dart:io';

import 'package:fixit/core/di/core_providers.dart';
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/core/errors/failure_messages.dart';
import 'package:fixit/core/routing/app_router.dart';
import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/adaptive.dart';
import 'package:fixit/core/ui/icon_badge.dart';
import 'package:fixit/core/ui/mode_badge.dart';
import 'package:fixit/features/assistant/presentation/job_screen.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/jobs_providers.dart';
import 'package:fixit/features/jobs/presentation/widgets/empty_jobs.dart';
import 'package:fixit/features/jobs/presentation/widgets/job_tile.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The jobs list. On a phone, opening a job pushes it; on a tablet the list
/// and the open job sit side by side.
class JobsScreen extends ConsumerWidget {
  const JobsScreen({super.key});

  static const listPaneWidth = 380.0;

  void _open(BuildContext context, WidgetRef ref, String jobId) {
    if (WindowSize.of(context) == WindowSize.expanded) {
      ref.read(selectedJobIdProvider.notifier).select(jobId);
    } else {
      unawaited(context.push(AppRoutes.job(jobId)));
    }
  }

  void _newJob(BuildContext context, WidgetRef ref) =>
      _open(context, ref, ref.read(uuidProvider).v4());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final expanded = WindowSize.of(context) == WindowSize.expanded;
    final selected = ref.watch(selectedJobIdProvider);
    // The empty state has its own call to action; a second one in the FAB
    // would just be noise.
    final hasJobs = ref.watch(jobsProvider).value?.isNotEmpty ?? false;

    final list = _JobsList(
      selectedId: expanded ? selected : null,
      onOpen: (id) => _open(context, ref, id),
      onNewJob: () => _newJob(context, ref),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.jobsTitle),
        actions: const [ModeBadge()],
      ),
      floatingActionButton: hasJobs || expanded
          ? FloatingActionButton.extended(
              onPressed: () => _newJob(context, ref),
              icon: const Icon(Icons.add_rounded),
              label: Text(l10n.newJob),
            )
          : null,
      floatingActionButtonLocation: expanded
          ? FloatingActionButtonLocation.startFloat
          : FloatingActionButtonLocation.endFloat,
      body: expanded
          ? Row(
              children: [
                SizedBox(width: listPaneWidth, child: list),
                const VerticalDivider(width: 1),
                Expanded(
                  child: selected == null
                      ? const _SelectJobPlaceholder()
                      : JobScreen(
                          key: ValueKey(selected),
                          jobId: selected,
                          embedded: true,
                        ),
                ),
              ],
            )
          : list,
    );
  }
}

class _JobsList extends ConsumerWidget {
  const _JobsList({
    required this.selectedId,
    required this.onOpen,
    required this.onNewJob,
  });

  final String? selectedId;
  final ValueChanged<String> onOpen;
  final VoidCallback onNewJob;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final jobs = ref.watch(jobsProvider);
    final photos = ref.watch(photoStoreProvider);

    return switch (jobs) {
      AsyncData(value: []) => EmptyJobs(onNewJob: onNewJob),
      AsyncData(:final value) => ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          Insets.lg,
          Insets.sm,
          Insets.lg,
          96,
        ),
        itemCount: value.length,
        separatorBuilder: (_, _) => const SizedBox(height: Insets.sm),
        itemBuilder: (context, index) {
          final job = value[index];
          return ContentWidth(
            child: Dismissible(
              key: ValueKey(job.id),
              direction: DismissDirection.endToStart,
              background: const _DeleteBackground(),
              confirmDismiss: (_) => _confirmDelete(context),
              onDismissed: (_) => unawaited(_delete(context, ref, job)),
              child: JobTile(
                job: job,
                selected: job.id == selectedId,
                thumbnail: job.thumbnailPath == null
                    ? null
                    : File(photos.absolutePath(job.thumbnailPath!)),
                onTap: () => onOpen(job.id),
              ),
            ),
          );
        },
      ),
      AsyncError(:final error) => Center(
        child: Padding(
          padding: const EdgeInsets.all(Insets.xl),
          child: Text(
            error is AppFailure
                ? error.localizedMessage(l10n)
                : l10n.failureUnknown,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteJobConfirmTitle),
        content: Text(l10n.deleteJobConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  Future<void> _delete(BuildContext context, WidgetRef ref, Job job) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    if (ref.read(selectedJobIdProvider) == job.id) {
      ref.read(selectedJobIdProvider.notifier).select(null);
    }
    try {
      await ref.read(jobsActionsProvider).delete(job.id);
      messenger.showSnackBar(SnackBar(content: Text(l10n.jobDeleted)));
    } on AppFailure catch (failure) {
      messenger.showSnackBar(
        SnackBar(content: Text(failure.localizedMessage(l10n))),
      );
    }
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      alignment: AlignmentDirectional.centerEnd,
      padding: const EdgeInsetsDirectional.only(end: Insets.xl),
      decoration: BoxDecoration(
        color: scheme.errorContainer,
        borderRadius: BorderRadius.circular(Radii.lg),
      ),
      child: Icon(
        Icons.delete_outline_rounded,
        color: scheme.onErrorContainer,
        semanticLabel: AppLocalizations.of(context).deleteJob,
      ),
    );
  }
}

class _SelectJobPlaceholder extends StatelessWidget {
  const _SelectJobPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const IconBadge(icon: Icons.handyman_outlined, size: 64),
          const SizedBox(height: Insets.lg),
          Text(
            AppLocalizations.of(context).selectJobHint,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
