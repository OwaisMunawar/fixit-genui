// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Fixit';

  @override
  String get jobsTitle => 'Jobs';

  @override
  String get newJob => 'New job';

  @override
  String get newJobTitle => 'New job';

  @override
  String get emptyJobsTitle => 'No repair jobs yet';

  @override
  String get emptyJobsBody =>
      'Describe a problem or snap a photo. Fixit answers with a plan you can tick off, not a wall of text.';

  @override
  String get statusDiagnosing => 'Diagnosing';

  @override
  String get statusInProgress => 'In progress';

  @override
  String get statusDone => 'Done';

  @override
  String jobUpdatedAt(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Updated $dateString';
  }

  @override
  String jobStepsProgress(int done, int total) {
    return '$done/$total steps';
  }

  @override
  String get deleteJob => 'Delete job';

  @override
  String get deleteJobConfirmTitle => 'Delete this job?';

  @override
  String get deleteJobConfirmBody =>
      'Its messages, photos and checklist progress are removed from this device.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get demoModeBadge => 'Demo mode';

  @override
  String get demoModeExplainer =>
      'Answers are scripted, so the app works offline with no API key. Pass GEMINI_API_KEY to use Gemini.';

  @override
  String get geminiModeBadge => 'Gemini';

  @override
  String get composerHint => 'Describe the problem';

  @override
  String get attachPhoto => 'Add a photo';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseFromLibrary => 'Choose from library';

  @override
  String get removePhoto => 'Remove photo';

  @override
  String get send => 'Send';

  @override
  String get thinking => 'Working out a plan';

  @override
  String get samplesTitle => 'Try a sample problem';

  @override
  String get sampleLeakyFaucet => 'Leaky faucet';

  @override
  String get sampleLeakyFaucetPrompt =>
      'My kitchen faucet keeps dripping even when the handle is fully closed.';

  @override
  String get sampleTrippedBreaker => 'Tripped breaker';

  @override
  String get sampleTrippedBreakerPrompt =>
      'The kitchen breaker keeps tripping when the microwave and kettle run together.';

  @override
  String get sampleCrackedTile => 'Cracked tile';

  @override
  String get sampleCrackedTilePrompt =>
      'A bathroom floor tile cracked across the middle and one corner feels loose.';

  @override
  String get errorTitle => 'That didn\'t work';

  @override
  String get retry => 'Try again';

  @override
  String get failureOffline =>
      'You appear to be offline. Demo mode still works without a connection.';

  @override
  String get failureInvalidKey =>
      'Gemini rejected the API key. Check GEMINI_API_KEY and rebuild.';

  @override
  String get failureRateLimited =>
      'Gemini is rate limiting requests. Wait a moment and try again.';

  @override
  String get failureBlocked =>
      'The model declined to answer this one. Try describing it differently.';

  @override
  String get failureService =>
      'Gemini is unavailable right now. Try again shortly.';

  @override
  String get failureStorage => 'This job couldn\'t be saved on the device.';

  @override
  String get failureUnknown => 'Something unexpected happened.';

  @override
  String get userPhotoSemantics => 'Photo of the problem';

  @override
  String get photoAttachedSemantics => 'Photo attached';

  @override
  String get likelyCause => 'Likely cause';

  @override
  String get alsoPossible => 'Also possible';

  @override
  String confidenceLabel(int percent) {
    return '$percent% confident';
  }

  @override
  String get difficultyEasy => 'Easy';

  @override
  String get difficultyModerate => 'Moderate';

  @override
  String get difficultyHard => 'Hard';

  @override
  String get difficultyPro => 'Pro only';

  @override
  String get submitAnswers => 'Submit answers';

  @override
  String get answered => 'Answered';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get requiredQuestion => 'Required';

  @override
  String checklistProgress(int done, int total) {
    return '$done of $total done';
  }

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String aboutMinutes(int minutes) {
    return 'About $minutes min';
  }

  @override
  String get safety => 'Safety';

  @override
  String get partsTitle => 'Parts and tools';

  @override
  String quantity(int qty) {
    return '×$qty';
  }

  @override
  String get estimatedTotal => 'Estimated total';

  @override
  String get tools => 'Tools';

  @override
  String get callAPro => 'Call a pro';

  @override
  String get whyAPro => 'Why a pro';

  @override
  String get typicalCost => 'Typical cost';

  @override
  String get addedBySafetyCheck => 'Added by Fixit\'s safety check';

  @override
  String get fallbackTitle => 'Part of this answer couldn\'t be shown';

  @override
  String get stepDone => 'Done';

  @override
  String get stepNotDone => 'Not done';

  @override
  String get untitledJob => 'Untitled job';

  @override
  String get failurePermission =>
      'Fixit needs access to the camera or photos. You can allow it in Settings.';

  @override
  String get assistantLabel => 'Fixit';

  @override
  String get newJobIntro =>
      'Describe what\'s wrong, add a photo if it helps, and Fixit answers with something you can tick off.';

  @override
  String get selectJobHint => 'Pick a job, or start a new one.';

  @override
  String get jobDeleted => 'Job deleted';
}
