/// Component names as the model sees them. Changing one is a protocol change:
/// saved jobs replay with these names, so treat them as a public API.
abstract final class CatalogNames {
  static const responseStack = 'ResponseStack';
  static const diagnosisCard = 'DiagnosisCard';
  static const questionForm = 'QuestionForm';
  static const stepChecklist = 'StepChecklist';
  static const partsList = 'PartsList';
  static const proCallout = 'ProCallout';
  static const safetyBanner = 'SafetyBanner';
  static const noteCard = 'NoteCard';

  /// The action name a [questionForm] dispatches when answers are submitted.
  static const submitAnswersAction = 'submitAnswers';
}

/// Data-model paths owned by the app, not the model.
///
/// The model never writes here; widgets do, and the session persists what they
/// write so a reopened job restores ticked steps and submitted answers.
abstract final class FixitDataPaths {
  static String checklist(String componentId) =>
      '/fixit/checklists/$componentId';

  static String formAnswers(String componentId) => '/fixit/forms/$componentId';
}
