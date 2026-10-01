import 'package:fixit/genui/catalog/bound_value_builder.dart';
import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/items/schema_fragments.dart';
import 'package:fixit/genui/catalog/models/question_form_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/catalog/typed_catalog_item.dart';
import 'package:fixit/genui/catalog/widgets/question_form_view.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

final questionFormSchema = S.object(
  description:
      'Clarifying questions, answered with taps rather than typing. The '
      'answers come back to you as the next user turn. Ask at most four '
      'questions and only ones that change your advice.',
  properties: {
    'title': S.string(minLength: 1, maxLength: 80),
    'intro': S.string(maxLength: 200),
    'submitLabel': S.string(maxLength: 30),
    'questions': S.list(
      minItems: 1,
      maxItems: 6,
      items: S.object(
        properties: {
          'id': S.string(
            description: 'Stable key for the answer, e.g. "handles".',
            pattern: r'^[a-zA-Z][a-zA-Z0-9_]{0,39}$',
          ),
          'label': S.string(minLength: 1, maxLength: 120),
          'type': S.string(
            enumValues: SchemaFragments.names(QuestionType.values),
          ),
          'options': S.list(
            description: 'Required for singleChoice and multiChoice.',
            maxItems: 8,
            items: S.object(
              properties: {
                'value': S.string(minLength: 1, maxLength: 40),
                'label': S.string(minLength: 1, maxLength: 60),
              },
              required: ['value', 'label'],
            ),
          ),
          'min': S.number(description: 'Slider only.'),
          'max': S.number(description: 'Slider only.'),
          'step': S.number(description: 'Slider only.', exclusiveMinimum: 0),
          'unit': S.string(description: 'Slider only.', maxLength: 20),
          'helper': S.string(maxLength: 160),
          'required': S.boolean(),
        },
        required: ['id', 'label', 'type'],
      ),
    ),
  },
  required: ['title', 'questions'],
);

final CatalogItem questionFormItem = typedCatalogItem<QuestionFormData>(
  name: CatalogNames.questionForm,
  schema: questionFormSchema,
  parse: QuestionFormData.fromJson,
  builder: (itemContext, data) {
    final path = FixitDataPaths.formAnswers(itemContext.id);
    return BoundValueBuilder<Map<String, Object?>>(
      dataContext: itemContext.dataContext,
      path: path,
      builder: (context, submitted) => QuestionFormView(
        data: data,
        submittedAnswers: submitted,
        onSubmit: (submission) {
          // Lock the form locally first so a slow model response can't
          // invite a second submission.
          itemContext.dataContext.update(DataPath(path), submission.answers);
          itemContext.dispatchEvent(
            UserActionEvent(
              name: CatalogNames.submitAnswersAction,
              sourceComponentId: itemContext.id,
              context: {'formTitle': data.title, ...submission.toJson()},
            ),
          );
        },
      ),
    );
  },
  examples: [
    () => '''
[
  {
    "id": "root",
    "component": "QuestionForm",
    "title": "A few quick questions",
    "questions": [
      {
        "id": "handles",
        "label": "How many handles does it have?",
        "type": "singleChoice",
        "options": [
          {"value": "single", "label": "One lever"},
          {"value": "double", "label": "Two handles"}
        ]
      },
      {"id": "shutoff", "label": "Can you reach the shut-off valve?", "type": "yesNo"},
      {"id": "drips", "label": "Drips per minute", "type": "slider", "min": 0, "max": 60, "step": 5}
    ]
  }
]''',
  ],
);
