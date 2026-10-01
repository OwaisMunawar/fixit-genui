import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

/// Marks content the safety guardrail added on the model's behalf.
class OriginCaption extends StatelessWidget {
  const OriginCaption({required this.origin, this.color, super.key});

  final ContentOrigin origin;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (origin != ContentOrigin.guardrail) return const SizedBox.shrink();
    final theme = Theme.of(context);
    final effective = color ?? theme.colorScheme.onSurfaceVariant;
    return Row(
      children: [
        Icon(Icons.verified_user_outlined, size: 14, color: effective),
        const SizedBox(width: Insets.xs),
        Expanded(
          child: Text(
            AppLocalizations.of(context).addedBySafetyCheck,
            style: theme.textTheme.labelSmall?.copyWith(color: effective),
          ),
        ),
      ],
    );
  }
}
