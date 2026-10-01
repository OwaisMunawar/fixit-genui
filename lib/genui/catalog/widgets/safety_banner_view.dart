import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/fixit_card.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/genui/catalog/models/safety_banner_data.dart';
import 'package:fixit/genui/catalog/widgets/catalog_visuals.dart';
import 'package:fixit/genui/catalog/widgets/origin_caption.dart';
import 'package:flutter/material.dart';

class SafetyBannerView extends StatelessWidget {
  const SafetyBannerView({required this.data, super.key});

  final SafetyBannerData data;

  @override
  Widget build(BuildContext context) {
    final tone = data.severity.tone;
    final colors = tone.resolve(context);
    return Semantics(
      liveRegion: true,
      container: true,
      child: FixitCard(
        filled: true,
        tone: tone,
        icon: data.severity.icon,
        title: data.title,
        footer: OriginCaption(origin: data.origin, color: colors.onContainer),
        child: Padding(
          padding: const EdgeInsets.only(right: Insets.xs),
          child: Text(
            data.message,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colors.onContainer),
          ),
        ),
      ),
    );
  }
}
