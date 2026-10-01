import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/core/errors/failure_messages.dart';
import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class FailureBanner extends StatelessWidget {
  const FailureBanner({
    required this.failure,
    required this.onRetry,
    required this.onDismiss,
    super.key,
  });

  final AppFailure failure;
  final VoidCallback onRetry;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Tone.danger.resolve(context);
    final theme = Theme.of(context);
    return Semantics(
      liveRegion: true,
      child: Material(
        color: colors.container,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Insets.lg,
            Insets.sm,
            Insets.xs,
            Insets.sm,
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline_rounded, color: colors.onContainer),
              const SizedBox(width: Insets.md),
              Expanded(
                child: Text(
                  failure.localizedMessage(l10n),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onContainer,
                  ),
                ),
              ),
              if (failure.isRetryable)
                TextButton(onPressed: onRetry, child: Text(l10n.retry)),
              IconButton(
                onPressed: onDismiss,
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                icon: Icon(Icons.close_rounded, color: colors.onContainer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
