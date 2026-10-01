import 'package:fixit/genui/catalog/items/diagnosis_card_item.dart';
import 'package:fixit/genui/catalog/items/note_card_item.dart';
import 'package:fixit/genui/catalog/items/parts_list_item.dart';
import 'package:fixit/genui/catalog/items/pro_callout_item.dart';
import 'package:fixit/genui/catalog/items/question_form_item.dart';
import 'package:fixit/genui/catalog/items/response_stack_item.dart';
import 'package:fixit/genui/catalog/items/safety_banner_item.dart';
import 'package:fixit/genui/catalog/items/step_checklist_item.dart';
import 'package:genui/genui.dart';

/// The complete vocabulary the model may answer with.
///
/// Deliberately small and domain-specific: the basic catalog's rows, columns
/// and text fields would let the model build anything, which is exactly what
/// makes its output hard to validate and inconsistent to look at.
abstract final class FixitCatalog {
  /// Bump the version when a schema changes incompatibly. Saved jobs keep
  /// their catalog id, which is what lets an older job be detected later.
  static const id = 'com.owaismunawar.fixit.catalog.v1';

  static final List<CatalogItem> items = [
    responseStackItem,
    safetyBannerItem,
    diagnosisCardItem,
    questionFormItem,
    stepChecklistItem,
    partsListItem,
    proCalloutItem,
    noteCardItem,
  ];

  static final Catalog catalog = Catalog(
    items,
    catalogId: id,
    systemPromptFragments: const [
      '''
Compose every answer as one surface whose root component has id "root" and is
a ResponseStack. Order its children like this:
1. SafetyBanner, whenever there is any hazard.
2. DiagnosisCard, in the first answer for a problem.
3. QuestionForm, when an answer would change your advice. Ask before giving
   a full plan if key facts are missing.
4. StepChecklist, once you know enough to give a plan.
5. PartsList, alongside the checklist.
6. ProCallout, when the job is not safe or sensible as DIY.
Use NoteCard only for a short remark that fits nowhere else.''',
      '''
Keep text inside components short and concrete. Give prices as typical retail
figures in the user's likely currency. Never invent a total; the app sums it.''',
    ],
  );
}
