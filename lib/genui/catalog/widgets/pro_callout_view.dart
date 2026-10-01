import 'package:fixit/core/format/formatters.dart';
import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/fixit_card.dart';
import 'package:fixit/core/ui/section_header.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/genui/catalog/models/pro_callout_data.dart';
import 'package:fixit/genui/catalog/widgets/bullet_list.dart';
import 'package:fixit/genui/catalog/widgets/origin_caption.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class ProCalloutView extends StatelessWidget {
  const ProCalloutView({required this.data, super.key});

  final ProCalloutData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final low = data.costLow <= data.costHigh ? data.costLow : data.costHigh;
    final high = data.costLow <= data.costHigh ? data.costHigh : data.costLow;

    return FixitCard(
      icon: Icons.engineering_outlined,
      tone: Tone.info,
      title: data.title,
      subtitle: data.trade ?? l10n.callAPro,
      footer: OriginCaption(origin: data.origin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(l10n.whyAPro),
          BulletList(data.reasons),
          const SizedBox(height: Insets.md),
          Container(
            padding: const EdgeInsets.all(Insets.md),
            decoration: BoxDecoration(
              color: Tone.info.resolve(context).container,
              borderRadius: BorderRadius.circular(Radii.md),
            ),
            child: MergeSemantics(
              // Wraps onto two lines at large text sizes instead of
              // overflowing.
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: Insets.md,
                runSpacing: Insets.xs,
                children: [
                  Text(
                    l10n.typicalCost,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Tone.info.resolve(context).onContainer,
                    ),
                  ),
                  Text(
                    formatMoneyRange(
                      low,
                      high,
                      currency: data.currency,
                      locale: locale,
                    ),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Tone.info.resolve(context).onContainer,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
