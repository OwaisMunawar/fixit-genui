import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/items/schema_fragments.dart';
import 'package:fixit/genui/catalog/models/note_card_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:fixit/genui/catalog/widgets/note_card_view.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final noteCardSchema = S.object(
  description:
      'A short note of one to three sentences. Use sparingly, only when no '
      'other component fits. Never put steps, parts or safety warnings here.',
  properties: {
    'title': S.string(maxLength: 80),
    'body': S.string(minLength: 1, maxLength: 600),
    'tone': S.string(enumValues: SchemaFragments.names(NoteTone.values)),
    'origin': SchemaFragments.origin(),
  },
  required: ['body'],
);

final CatalogItem noteCardItem = typedCatalogItem<NoteCardData>(
  name: CatalogNames.noteCard,
  schema: noteCardSchema,
  parse: NoteCardData.fromJson,
  builder: (_, data) => NoteCardView(data: data),
  examples: [
    () => '''
[
  {
    "id": "root",
    "component": "NoteCard",
    "title": "Good news",
    "body": "This is usually a twenty minute fix with basic tools."
  }
]''',
  ],
);
