import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/items/schema_fragments.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/catalog/models/safety_banner_data.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:fixit/genui/catalog/widgets/safety_banner_view.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final safetyBannerSchema = S.object(
  description:
      'A prominent safety warning, placed first in the answer. Required for '
      'any electrical, gas or structural problem.',
  properties: {
    'severity': S.string(
      description:
          'danger: risk of injury, stop now. warning: hazardous if done '
          'wrong. caution: minor risk.',
      enumValues: SchemaFragments.names(SafetySeverity.values),
    ),
    'title': S.string(minLength: 1, maxLength: 80),
    'message': S.string(minLength: 1, maxLength: 400),
    'origin': SchemaFragments.origin(),
  },
  required: ['severity', 'title', 'message'],
);

final CatalogItem safetyBannerItem = typedCatalogItem<SafetyBannerData>(
  name: CatalogNames.safetyBanner,
  schema: safetyBannerSchema,
  parse: SafetyBannerData.fromJson,
  builder: (_, data) => SafetyBannerView(data: data),
  examples: [
    () => '''
[
  {
    "id": "root",
    "component": "SafetyBanner",
    "severity": "warning",
    "title": "Switch off the circuit first",
    "message": "Turn the breaker off and confirm the outlet is dead with a tester before touching any wiring."
  }
]''',
  ],
);
