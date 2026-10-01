import 'package:fixit/core/format/formatters.dart';
import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/fixit_card.dart';
import 'package:fixit/core/ui/info_chip.dart';
import 'package:fixit/core/ui/section_header.dart';
import 'package:fixit/genui/catalog/models/parts_list_data.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

class PartsListView extends StatelessWidget {
  const PartsListView({required this.data, super.key});

  final PartsListData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    String money(num v) =>
        formatMoney(v, currency: data.currency, locale: locale);

    return FixitCard(
      icon: Icons.shopping_basket_outlined,
      title: data.title ?? l10n.partsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final item in data.items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.sm),
              child: MergeSemantics(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: theme.textTheme.bodyLarge),
                          if (item.note != null)
                            Text(
                              item.note!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: Insets.md),
                    Text(
                      l10n.quantity(item.quantity),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(
                      width: 72,
                      child: Text(
                        item.lineTotal == null ? '' : money(item.lineTotal!),
                        textAlign: TextAlign.end,
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (data.hasPricing) ...[
            const Divider(height: Insets.lg),
            MergeSemantics(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.estimatedTotal,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  Text(
                    money(data.estimatedTotal),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (data.tools.isNotEmpty) ...[
            const SizedBox(height: Insets.lg),
            SectionHeader(l10n.tools, icon: Icons.construction_rounded),
            const SizedBox(height: Insets.xs),
            Wrap(
              spacing: Insets.sm,
              runSpacing: Insets.sm,
              children: [for (final tool in data.tools) InfoChip(label: tool)],
            ),
          ],
        ],
      ),
    );
  }
}
