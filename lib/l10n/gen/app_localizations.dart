import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Fixit'**
  String get appTitle;

  /// No description provided for @jobsTitle.
  ///
  /// In en, this message translates to:
  /// **'Jobs'**
  String get jobsTitle;

  /// No description provided for @newJob.
  ///
  /// In en, this message translates to:
  /// **'New job'**
  String get newJob;

  /// No description provided for @newJobTitle.
  ///
  /// In en, this message translates to:
  /// **'New job'**
  String get newJobTitle;

  /// No description provided for @emptyJobsTitle.
  ///
  /// In en, this message translates to:
  /// **'No repair jobs yet'**
  String get emptyJobsTitle;

  /// No description provided for @emptyJobsBody.
  ///
  /// In en, this message translates to:
  /// **'Describe a problem or snap a photo. Fixit answers with a plan you can tick off, not a wall of text.'**
  String get emptyJobsBody;

  /// No description provided for @statusDiagnosing.
  ///
  /// In en, this message translates to:
  /// **'Diagnosing'**
  String get statusDiagnosing;

  /// No description provided for @statusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get statusInProgress;

  /// No description provided for @statusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get statusDone;

  /// No description provided for @jobUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String jobUpdatedAt(DateTime date);

  /// No description provided for @jobStepsProgress.
  ///
  /// In en, this message translates to:
  /// **'{done}/{total} steps'**
  String jobStepsProgress(int done, int total);

  /// No description provided for @deleteJob.
  ///
  /// In en, this message translates to:
  /// **'Delete job'**
  String get deleteJob;

  /// No description provided for @deleteJobConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this job?'**
  String get deleteJobConfirmTitle;

  /// No description provided for @deleteJobConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Its messages, photos and checklist progress are removed from this device.'**
  String get deleteJobConfirmBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @demoModeBadge.
  ///
  /// In en, this message translates to:
  /// **'Demo mode'**
  String get demoModeBadge;

  /// No description provided for @demoModeExplainer.
  ///
  /// In en, this message translates to:
  /// **'Answers are scripted, so the app works offline with no API key. Pass GEMINI_API_KEY to use Gemini.'**
  String get demoModeExplainer;

  /// No description provided for @geminiModeBadge.
  ///
  /// In en, this message translates to:
  /// **'Gemini'**
  String get geminiModeBadge;

  /// No description provided for @composerHint.
  ///
  /// In en, this message translates to:
  /// **'Describe the problem'**
  String get composerHint;

  /// No description provided for @attachPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get attachPhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @chooseFromLibrary.
  ///
  /// In en, this message translates to:
  /// **'Choose from library'**
  String get chooseFromLibrary;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get removePhoto;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @thinking.
  ///
  /// In en, this message translates to:
  /// **'Working out a plan'**
  String get thinking;

  /// No description provided for @samplesTitle.
  ///
  /// In en, this message translates to:
  /// **'Try a sample problem'**
  String get samplesTitle;

  /// No description provided for @sampleLeakyFaucet.
  ///
  /// In en, this message translates to:
  /// **'Leaky faucet'**
  String get sampleLeakyFaucet;

  /// No description provided for @sampleLeakyFaucetPrompt.
  ///
  /// In en, this message translates to:
  /// **'My kitchen faucet keeps dripping even when the handle is fully closed.'**
  String get sampleLeakyFaucetPrompt;

  /// No description provided for @sampleTrippedBreaker.
  ///
  /// In en, this message translates to:
  /// **'Tripped breaker'**
  String get sampleTrippedBreaker;

  /// No description provided for @sampleTrippedBreakerPrompt.
  ///
  /// In en, this message translates to:
  /// **'The kitchen breaker keeps tripping when the microwave and kettle run together.'**
  String get sampleTrippedBreakerPrompt;

  /// No description provided for @sampleCrackedTile.
  ///
  /// In en, this message translates to:
  /// **'Cracked tile'**
  String get sampleCrackedTile;

  /// No description provided for @sampleCrackedTilePrompt.
  ///
  /// In en, this message translates to:
  /// **'A bathroom floor tile cracked across the middle and one corner feels loose.'**
  String get sampleCrackedTilePrompt;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'That didn\'t work'**
  String get errorTitle;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @failureOffline.
  ///
  /// In en, this message translates to:
  /// **'You appear to be offline. Demo mode still works without a connection.'**
  String get failureOffline;

  /// No description provided for @failureInvalidKey.
  ///
  /// In en, this message translates to:
  /// **'Gemini rejected the API key. Check GEMINI_API_KEY and rebuild.'**
  String get failureInvalidKey;

  /// No description provided for @failureRateLimited.
  ///
  /// In en, this message translates to:
  /// **'Gemini is rate limiting requests. Wait a moment and try again.'**
  String get failureRateLimited;

  /// No description provided for @failureBlocked.
  ///
  /// In en, this message translates to:
  /// **'The model declined to answer this one. Try describing it differently.'**
  String get failureBlocked;

  /// No description provided for @failureService.
  ///
  /// In en, this message translates to:
  /// **'Gemini is unavailable right now. Try again shortly.'**
  String get failureService;

  /// No description provided for @failureStorage.
  ///
  /// In en, this message translates to:
  /// **'This job couldn\'t be saved on the device.'**
  String get failureStorage;

  /// No description provided for @failureUnknown.
  ///
  /// In en, this message translates to:
  /// **'Something unexpected happened.'**
  String get failureUnknown;

  /// No description provided for @userPhotoSemantics.
  ///
  /// In en, this message translates to:
  /// **'Photo of the problem'**
  String get userPhotoSemantics;

  /// No description provided for @photoAttachedSemantics.
  ///
  /// In en, this message translates to:
  /// **'Photo attached'**
  String get photoAttachedSemantics;

  /// No description provided for @likelyCause.
  ///
  /// In en, this message translates to:
  /// **'Likely cause'**
  String get likelyCause;

  /// No description provided for @alsoPossible.
  ///
  /// In en, this message translates to:
  /// **'Also possible'**
  String get alsoPossible;

  /// No description provided for @confidenceLabel.
  ///
  /// In en, this message translates to:
  /// **'{percent}% confident'**
  String confidenceLabel(int percent);

  /// No description provided for @difficultyEasy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get difficultyEasy;

  /// No description provided for @difficultyModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get difficultyModerate;

  /// No description provided for @difficultyHard.
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get difficultyHard;

  /// No description provided for @difficultyPro.
  ///
  /// In en, this message translates to:
  /// **'Pro only'**
  String get difficultyPro;

  /// No description provided for @submitAnswers.
  ///
  /// In en, this message translates to:
  /// **'Submit answers'**
  String get submitAnswers;

  /// No description provided for @answered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get answered;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @requiredQuestion.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredQuestion;

  /// No description provided for @checklistProgress.
  ///
  /// In en, this message translates to:
  /// **'{done} of {total} done'**
  String checklistProgress(int done, int total);

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(int minutes);

  /// No description provided for @aboutMinutes.
  ///
  /// In en, this message translates to:
  /// **'About {minutes} min'**
  String aboutMinutes(int minutes);

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safety;

  /// No description provided for @partsTitle.
  ///
  /// In en, this message translates to:
  /// **'Parts and tools'**
  String get partsTitle;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'×{qty}'**
  String quantity(int qty);

  /// No description provided for @estimatedTotal.
  ///
  /// In en, this message translates to:
  /// **'Estimated total'**
  String get estimatedTotal;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @callAPro.
  ///
  /// In en, this message translates to:
  /// **'Call a pro'**
  String get callAPro;

  /// No description provided for @whyAPro.
  ///
  /// In en, this message translates to:
  /// **'Why a pro'**
  String get whyAPro;

  /// No description provided for @typicalCost.
  ///
  /// In en, this message translates to:
  /// **'Typical cost'**
  String get typicalCost;

  /// No description provided for @addedBySafetyCheck.
  ///
  /// In en, this message translates to:
  /// **'Added by Fixit\'s safety check'**
  String get addedBySafetyCheck;

  /// No description provided for @fallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Part of this answer couldn\'t be shown'**
  String get fallbackTitle;

  /// No description provided for @stepDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get stepDone;

  /// No description provided for @stepNotDone.
  ///
  /// In en, this message translates to:
  /// **'Not done'**
  String get stepNotDone;

  /// No description provided for @untitledJob.
  ///
  /// In en, this message translates to:
  /// **'Untitled job'**
  String get untitledJob;

  /// No description provided for @failurePermission.
  ///
  /// In en, this message translates to:
  /// **'Fixit needs access to the camera or photos. You can allow it in Settings.'**
  String get failurePermission;

  /// No description provided for @assistantLabel.
  ///
  /// In en, this message translates to:
  /// **'Fixit'**
  String get assistantLabel;

  /// No description provided for @newJobIntro.
  ///
  /// In en, this message translates to:
  /// **'Describe what\'s wrong, add a photo if it helps, and Fixit answers with something you can tick off.'**
  String get newJobIntro;

  /// No description provided for @selectJobHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a job, or start a new one.'**
  String get selectJobHint;

  /// No description provided for @jobDeleted.
  ///
  /// In en, this message translates to:
  /// **'Job deleted'**
  String get jobDeleted;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
