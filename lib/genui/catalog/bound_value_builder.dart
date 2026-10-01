import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:genui/genui.dart';

/// Rebuilds when one data-model path changes.
///
/// genui hands out a fresh notifier per `subscribe` call and leaves disposal
/// to the caller, so this owns that lifecycle in one place instead of every
/// catalog item getting it slightly wrong.
class BoundValueBuilder<T> extends StatefulWidget {
  const BoundValueBuilder({
    required this.dataContext,
    required this.path,
    required this.builder,
    super.key,
  });

  final DataContext dataContext;
  final String path;
  final Widget Function(BuildContext context, T? value) builder;

  @override
  State<BoundValueBuilder<T>> createState() => _BoundValueBuilderState<T>();
}

class _BoundValueBuilderState<T> extends State<BoundValueBuilder<T>> {
  late ValueListenable<T?> _listenable = _subscribe();

  ValueListenable<T?> _subscribe() =>
      widget.dataContext.subscribe<T>(DataPath(widget.path));

  @override
  void didUpdateWidget(BoundValueBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path ||
        oldWidget.dataContext.dataModel != widget.dataContext.dataModel) {
      _release();
      _listenable = _subscribe();
    }
  }

  void _release() {
    final listenable = _listenable;
    if (listenable is ChangeNotifier) (listenable as ChangeNotifier).dispose();
  }

  @override
  void dispose() {
    _release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<T?>(
    valueListenable: _listenable,
    builder: (context, value, _) => widget.builder(context, value),
  );
}
