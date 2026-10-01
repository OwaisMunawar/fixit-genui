import 'package:flutter/widgets.dart';

/// Material 3 window size classes, trimmed to the two this app lays out for.
enum WindowSize {
  compact,
  expanded;

  static WindowSize of(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= 840 ? expanded : compact;
}

/// Keeps reading width comfortable on tablets instead of stretching cards
/// across a 13-inch screen.
class ContentWidth extends StatelessWidget {
  const ContentWidth({required this.child, this.maxWidth = 720, super.key});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
