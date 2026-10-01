import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:flutter/material.dart';

class IconBadge extends StatelessWidget {
  const IconBadge({
    required this.icon,
    this.tone = Tone.brand,
    this.size = 40,
    super.key,
  });

  final IconData icon;
  final Tone tone;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = tone.resolve(context);
    return ExcludeSemantics(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colors.container,
          borderRadius: BorderRadius.circular(Radii.md),
        ),
        child: Icon(icon, size: size * 0.55, color: colors.onContainer),
      ),
    );
  }
}
