import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/items/schema_fragments.dart';
import 'package:fixit/genui/catalog/models/diagnosis_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:fixit/genui/catalog/widgets/diagnosis_card_view.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final diagnosisCardSchema = S.object(
  description:
      'Your best diagnosis of the problem. Use exactly one per job, in the '
      'first answer, and again only if new information changes it.',
  properties: {
    'title': S.string(
      description: 'Short name of the problem, e.g. "Dripping kitchen tap".',
      minLength: 1,
      maxLength: 60,
    ),
    'likelyCause': S.string(
      description: 'One or two sentences on the most likely cause.',
      minLength: 1,
      maxLength: 300,
    ),
    'confidence': S.number(
      description: 'How sure you are, from 0 to 1.',
      minimum: 0,
      maximum: 1,
    ),
    'difficulty': S.string(
      description: 'Use "pro" when a homeowner should not attempt it.',
      enumValues: SchemaFragments.names(Difficulty.values),
    ),
    'category': S.string(
      enumValues: SchemaFragments.names(RepairCategory.values),
    ),
    'summary': S.string(maxLength: 300),
    'estimatedMinutes': S.integer(minimum: 1, maximum: 2880),
    'alternatives': S.list(
      description: 'Other plausible causes, most likely first.',
      items: S.string(maxLength: 120),
      maxItems: 4,
    ),
  },
  required: ['title', 'likelyCause', 'confidence', 'difficulty', 'category'],
);

final CatalogItem diagnosisCardItem = typedCatalogItem<DiagnosisData>(
  name: CatalogNames.diagnosisCard,
  schema: diagnosisCardSchema,
  parse: DiagnosisData.fromJson,
  builder: (_, data) => DiagnosisCardView(data: data),
  examples: [
    () => '''
[
  {
    "id": "root",
    "component": "DiagnosisCard",
    "title": "Dripping kitchen tap",
    "likelyCause": "A worn cartridge or O-ring is letting water past the valve.",
    "confidence": 0.75,
    "difficulty": "easy",
    "category": "plumbing",
    "estimatedMinutes": 45,
    "alternatives": ["Mineral build-up on the valve seat"]
  }
]''',
  ],
);
