import 'package:fixit/core/ui/info_chip.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip(this.status, {super.key});

  final JobStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, icon, tone) = switch (status) {
      JobStatus.diagnosing => (
        l10n.statusDiagnosing,
        Icons.search_rounded,
        Tone.info,
      ),
      JobStatus.inProgress => (
        l10n.statusInProgress,
        Icons.construction_rounded,
        Tone.warning,
      ),
      JobStatus.done => (l10n.statusDone, Icons.check_rounded, Tone.success),
    };
    return InfoChip(label: label, icon: icon, tone: tone);
  }
}
