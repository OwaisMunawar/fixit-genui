import 'package:fixit/core/ui/fixit_card.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/genui/catalog/models/note_card_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

/// Short prose from the model, and the fallback for anything that failed
/// validation.
class NoteCardView extends StatelessWidget {
  const NoteCardView({required this.data, super.key});

  final NoteCardData data;
  bool get isFallback => data.origin == ContentOrigin.validator;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tone = data.tone == NoteTone.warning ? Tone.warning : Tone.info;
    final title = isFallback ? l10n.fallbackTitle : data.title;
    final body = Text(data.body, style: Theme.of(context).textTheme.bodyMedium);

    return FixitCard(
      title: title,
      tone: tone,
      icon: isFallback
          ? Icons.report_gmailerrorred_rounded
          : Icons.lightbulb_outline_rounded,
      child: data.body.isEmpty ? const SizedBox.shrink() : body,
    );
  }
}
