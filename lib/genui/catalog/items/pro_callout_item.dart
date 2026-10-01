import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/items/schema_fragments.dart';
import 'package:fixit/genui/catalog/models/pro_callout_data.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:fixit/genui/catalog/widgets/pro_callout_view.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final proCalloutSchema = S.object(
  description:
      'Recommends hiring a professional and explains why. Required for any '
      'electrical, gas or structural problem, and whenever difficulty is '
      '"pro".',
  properties: {
    'title': S.string(minLength: 1, maxLength: 80),
    'trade': S.string(
      description: 'Who to call, e.g. "Licensed electrician".',
      maxLength: 60,
    ),
    'reasons': S.list(
      minItems: 1,
      maxItems: 5,
      items: S.string(minLength: 1, maxLength: 160),
    ),
    'costLow': SchemaFragments.money('Low end of a typical call-out.'),
    'costHigh': SchemaFragments.money('High end of a typical call-out.'),
    'currency': SchemaFragments.currency(),
    'origin': SchemaFragments.origin(),
  },
  required: ['title', 'reasons', 'costLow', 'costHigh'],
);

final CatalogItem proCalloutItem = typedCatalogItem<ProCalloutData>(
  name: CatalogNames.proCallout,
  schema: proCalloutSchema,
  parse: ProCalloutData.fromJson,
  builder: (_, data) => ProCalloutView(data: data),
  examples: [
    () => '''
[
  {
    "id": "root",
    "component": "ProCallout",
    "title": "Have an electrician check the circuit",
    "trade": "Licensed electrician",
    "reasons": ["The breaker trips with no load attached"],
    "costLow": 150,
    "costHigh": 350,
    "currency": "USD"
  }
]''',
  ],
);
