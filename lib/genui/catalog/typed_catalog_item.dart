import 'package:fixit/genui/catalog/models/note_card_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/catalog/widgets/note_card_view.dart';
import 'package:flutter/widgets.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

typedef TypedWidgetBuilder<T> =
    Widget Function(CatalogItemContext context, T data);

/// Builds a [CatalogItem] whose widget receives a parsed, typed model instead
/// of a raw JSON map.
///
/// Parsing failures render a fallback note rather than genui's red error
/// widget. Upstream validation should already have caught bad payloads; this
/// is the last line of defence for anything the schema cannot express.
CatalogItem typedCatalogItem<T>({
  required String name,
  required Schema schema,
  required T Function(Map<String, Object?> json) parse,
  required TypedWidgetBuilder<T> builder,
  List<ExampleBuilderCallback> examples = const [],
}) {
  return CatalogItem(
    name: name,
    dataSchema: schema,
    exampleData: examples,
    widgetBuilder: (itemContext) {
      final T data;
      try {
        data = parse(Map<String, Object?>.from(itemContext.data as Map));
      } on Object catch (error, stackTrace) {
        genUiLogger.warning('Could not parse $name payload', error, stackTrace);
        return const NoteCardView(
          data: NoteCardData(
            body: '',
            tone: NoteTone.warning,
            origin: ContentOrigin.validator,
          ),
        );
      }
      return builder(itemContext, data);
    },
  );
}
