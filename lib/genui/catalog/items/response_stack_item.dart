import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/models/response_stack_data.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:flutter/widgets.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final responseStackSchema = S.object(
  description:
      'The root of every answer. Stacks the other components vertically in '
      'the order given. Always use id "root" for this component.',
  properties: {
    'children': S.list(
      description: 'Component ids, top to bottom. Use at most eight.',
      items: S.string(),
      minItems: 1,
      // Two above the advertised limit, leaving room for the safety
      // guardrail to add a banner and a pro callout to a full answer.
      maxItems: 10,
    ),
  },
  required: ['children'],
);

final CatalogItem responseStackItem = typedCatalogItem<ResponseStackData>(
  name: CatalogNames.responseStack,
  schema: responseStackSchema,
  parse: ResponseStackData.fromJson,
  builder: (itemContext, data) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisSize: MainAxisSize.min,
    children: [
      for (final (index, childId) in data.children.indexed) ...[
        if (index > 0) const SizedBox(height: Insets.md),
        itemContext.buildChild(childId),
      ],
    ],
  ),
  examples: [
    () => '''
[
  {"id": "root", "component": "ResponseStack", "children": ["note"]},
  {"id": "note", "component": "NoteCard", "body": "Turn the water off first."}
]''',
  ],
);
