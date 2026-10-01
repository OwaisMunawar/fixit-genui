import 'package:fixit/genui/catalog/bound_value_builder.dart';
import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/models/step_checklist_data.dart';
import 'package:fixit/genui/catalog/surface_scope.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:fixit/genui/catalog/widgets/step_checklist_view.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final stepChecklistSchema = S.object(
  description:
      'The repair as ordered steps the user ticks off. One action per step. '
      'Put any hazard for a step in its "safety" field, not in the detail.',
  properties: {
    'title': S.string(minLength: 1, maxLength: 80),
    'estimatedMinutes': S.integer(minimum: 1, maximum: 2880),
    'steps': S.list(
      minItems: 1,
      maxItems: 15,
      items: S.object(
        properties: {
          'id': S.string(pattern: r'^[a-zA-Z0-9_-]{1,40}$'),
          'title': S.string(minLength: 1, maxLength: 100),
          'detail': S.string(maxLength: 400),
          'minutes': S.integer(minimum: 1, maximum: 600),
          'safety': S.string(maxLength: 200),
        },
        required: ['id', 'title'],
      ),
    ),
  },
  required: ['title', 'steps'],
);

final CatalogItem stepChecklistItem = typedCatalogItem<StepChecklistData>(
  name: CatalogNames.stepChecklist,
  schema: stepChecklistSchema,
  parse: StepChecklistData.fromJson,
  builder: (itemContext, data) {
    final path = FixitDataPaths.checklist(itemContext.id);
    return BoundValueBuilder<List<Object?>>(
      dataContext: itemContext.dataContext,
      path: path,
      builder: (context, value) {
        final completed = {...?value?.whereType<String>()};
        return StepChecklistView(
          data: data,
          completed: completed,
          onToggle: (stepId, {required done}) {
            final next = {...completed};
            done ? next.add(stepId) : next.remove(stepId);
            itemContext.dataContext.update(DataPath(path), next.toList());
            FixitSurfaceScope.maybeOf(
              context,
            )?.onChecklistChanged(itemContext.surfaceId, itemContext.id, next);
          },
        );
      },
    );
  },
  examples: [
    () => '''
[
  {
    "id": "root",
    "component": "StepChecklist",
    "title": "Replace the cartridge",
    "steps": [
      {"id": "shutoff", "title": "Shut off the water", "minutes": 2},
      {"id": "handle", "title": "Remove the handle", "detail": "Pry off the cap, then undo the screw.", "minutes": 5},
      {"id": "swap", "title": "Swap the cartridge", "minutes": 15, "safety": "Open the tap to release pressure first."}
    ]
  }
]''',
  ],
);
