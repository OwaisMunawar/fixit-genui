import 'package:flutter/widgets.dart';

/// Host callbacks for app-level side effects of generated widgets.
///
/// genui's data model already holds widget state; this scope only tells the
/// host when that state should be persisted. It is optional so catalog widgets
/// still render in isolation (tests, the catalog gallery).
class FixitSurfaceScope extends InheritedWidget {
  const FixitSurfaceScope({
    required this.onChecklistChanged,
    required super.child,
    super.key,
  });

  final void Function(
    String surfaceId,
    String componentId,
    Set<String> completedStepIds,
  )
  onChecklistChanged;

  static FixitSurfaceScope? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<FixitSurfaceScope>();

  @override
  bool updateShouldNotify(FixitSurfaceScope oldWidget) =>
      onChecklistChanged != oldWidget.onChecklistChanged;
}
