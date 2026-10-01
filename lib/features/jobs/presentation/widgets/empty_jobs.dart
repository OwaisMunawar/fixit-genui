import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/fixit_buttons.dart';
import 'package:fixit/core/ui/icon_badge.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class EmptyJobs extends StatelessWidget {
  const EmptyJobs({required this.onNewJob, super.key});

  final VoidCallback onNewJob;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Insets.xl),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const IconBadge(
                icon: Icons.home_repair_service_outlined,
                size: 72,
              ),
              const SizedBox(height: Insets.lg),
              Text(
                l10n.emptyJobsTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: Insets.sm),
              Text(
                l10n.emptyJobsBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: Insets.xl),
              PrimaryButton(
                label: l10n.newJob,
                icon: Icons.add_rounded,
                expand: false,
                onPressed: onNewJob,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
