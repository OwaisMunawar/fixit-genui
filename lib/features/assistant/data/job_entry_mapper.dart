import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/features/jobs/domain/photo_store.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/session/completed_turn.dart';
import 'package:fixit/genui/session/genui_session.dart';

/// Translates between the job's stored history and the genui session.
///
/// This is the seam between `features/` and `lib/genui`: the domain never
/// sees A2UI types and the session never sees drift rows.
final class JobEntryMapper {
  const JobEntryMapper(this._photos);

  final PhotoStore _photos;

  List<JobEntry> entriesFor(CompletedTurn turn, {required DateTime at}) => [
    if (turn.input case final AnswersInput answers)
      JobEntry.answers(
        surfaceId: answers.surfaceId,
        componentId: answers.componentId,
        formTitle: answers.formTitle,
        answers: answers.answers,
        summary: answers.summary,
        createdAt: at,
      ),
    JobEntry.model(
      rawResponse: turn.rawResponse,
      text: turn.processed.text,
      surfaceIds: turn.processed.surfaceIds,
      messages: turn.messages,
      checklists: checklistsFor(turn),
      categories: [for (final c in turn.processed.diagnosedCategories) c.name],
      createdAt: at,
    ),
  ];

  static List<ChecklistRef> checklistsFor(CompletedTurn turn) => [
    for (final outline in turn.checklists)
      ChecklistRef(
        surfaceId: outline.surfaceId,
        componentId: outline.componentId,
        stepIds: outline.stepIds,
      ),
  ];

  Future<SessionSnapshot> snapshotFor(
    List<JobEntry> entries,
    Map<ChecklistKey, Set<String>> progress,
  ) async {
    final history = <RepairTurn>[];
    final userTexts = <String>[];
    final categories = <RepairCategory>{};
    final messages = <Map<String, Object?>>[];
    final forms = <FormAnswersState>[];
    var turns = 0;

    for (final entry in entries) {
      switch (entry) {
        case UserEntry(:final text, :final imagePath):
          final bytes = imagePath == null
              ? null
              : await _photos.read(imagePath);
          history.add(
            RepairTurn(
              role: RepairRole.user,
              text: text,
              image: bytes == null
                  ? null
                  : ImageAttachment(bytes: bytes, path: imagePath),
            ),
          );
          userTexts.add(text);
        case final AnswersEntry answers:
          final input = AnswersInput(
            surfaceId: answers.surfaceId,
            componentId: answers.componentId,
            formTitle: answers.formTitle,
            answers: answers.answers,
            summary: answers.summary,
          );
          history.add(RepairTurn.fromInput(input));
          forms.add(
            FormAnswersState(
              surfaceId: answers.surfaceId,
              componentId: answers.componentId,
              answers: answers.answers,
            ),
          );
        case final ModelEntry model:
          history.add(
            RepairTurn(role: RepairRole.model, text: model.rawResponse),
          );
          messages.addAll(model.messages);
          categories.addAll(
            model.categories
                .map((name) => RepairCategory.values.asNameMap()[name])
                .nonNulls,
          );
          turns++;
      }
    }

    return SessionSnapshot(
      history: history,
      userTexts: userTexts,
      categories: categories,
      turnCount: turns,
      messages: messages,
      formAnswers: forms,
      checklists: [
        for (final MapEntry(:key, :value) in progress.entries)
          ChecklistState(
            surfaceId: key.surfaceId,
            componentId: key.componentId,
            completed: value,
          ),
      ],
    );
  }
}
