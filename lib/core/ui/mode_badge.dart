import 'package:fixit/core/config/app_config.dart';
import 'package:fixit/core/di/core_providers.dart';
import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/info_chip.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Says which generator is answering, so a scripted answer is never mistaken
/// for a live model.
class ModeBadge extends ConsumerWidget {
  const ModeBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final demo = ref.watch(appConfigProvider).mode == GeneratorMode.demo;
    return Padding(
      padding: const EdgeInsets.only(right: Insets.md),
      child: Tooltip(
        message: demo ? l10n.demoModeExplainer : l10n.geminiModeBadge,
        triggerMode: TooltipTriggerMode.tap,
        child: InfoChip(
          icon: demo ? Icons.science_outlined : Icons.auto_awesome_outlined,
          label: demo ? l10n.demoModeBadge : l10n.geminiModeBadge,
          tone: demo ? Tone.warning : Tone.brand,
        ),
      ),
    );
  }
}
