import 'dart:io';

import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({required this.text, this.imageFile, super.key});

  final String text;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: Insets.xxl),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(Radii.lg),
                topEnd: Radius.circular(Radii.lg),
                bottomStart: Radius.circular(Radii.lg),
                bottomEnd: Radius.circular(Insets.xs),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Insets.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (imageFile != null)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: text.isEmpty ? 0 : Insets.sm,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(Radii.md),
                        child: Image.file(
                          imageFile!,
                          height: 180,
                          fit: BoxFit.cover,
                          semanticLabel: AppLocalizations.of(
                            context,
                          ).userPhotoSemantics,
                          errorBuilder: (_, _, _) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  if (text.isNotEmpty)
                    Text(
                      text,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
