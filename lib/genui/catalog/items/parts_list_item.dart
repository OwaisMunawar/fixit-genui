import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/items/schema_fragments.dart';
import 'package:fixit/genui/catalog/models/parts_list_data.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:fixit/genui/catalog/widgets/parts_list_view.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final partsListSchema = S.object(
  description:
      'Parts to buy with rough prices, and tools needed. The app sums the '
      'total itself, so do not include one.',
  properties: {
    'title': S.string(maxLength: 80),
    'currency': SchemaFragments.currency(),
    'items': S.list(
      minItems: 1,
      maxItems: 15,
      items: S.object(
        properties: {
          'name': S.string(minLength: 1, maxLength: 80),
          'quantity': S.integer(minimum: 1, maximum: 999),
          'unitCost': SchemaFragments.money('Typical retail price for one.'),
          'note': S.string(maxLength: 120),
        },
        required: ['name'],
      ),
    ),
    'tools': S.list(items: S.string(maxLength: 40), maxItems: 12),
  },
  required: ['items'],
);

final CatalogItem partsListItem = typedCatalogItem<PartsListData>(
  name: CatalogNames.partsList,
  schema: partsListSchema,
  parse: PartsListData.fromJson,
  builder: (_, data) => PartsListView(data: data),
  examples: [
    () => '''
[
  {
    "id": "root",
    "component": "PartsList",
    "currency": "USD",
    "items": [
      {"name": "Single-lever cartridge", "quantity": 1, "unitCost": 22},
      {"name": "Plumber's grease", "quantity": 1, "unitCost": 6}
    ],
    "tools": ["Allen key set", "Adjustable wrench"]
  }
]''',
  ],
);
