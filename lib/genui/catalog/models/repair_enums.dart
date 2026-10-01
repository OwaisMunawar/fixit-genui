/// Trade a problem belongs to. The guardrail keys off [electrical], [gas] and
/// [structural]; the rest only affect copy and icons.
enum RepairCategory {
  plumbing,
  electrical,
  gas,
  structural,
  flooring,
  carpentry,
  appliance,
  hvac,
  roofing,
  general,
}

enum Difficulty { easy, moderate, hard, pro }

enum SafetySeverity {
  caution,
  warning,
  danger;

  bool isAtLeast(SafetySeverity other) => index >= other.index;
}

/// Who authored a component. App-authored components say so in the UI, which
/// keeps the app honest about what the model actually returned.
enum ContentOrigin {
  model,

  /// Added by the safety guardrail because the model left it out.
  guardrail,

  /// Substituted by the validator for a component that failed its schema.
  validator,
}

enum NoteTone { info, warning }

enum QuestionType { singleChoice, multiChoice, slider, yesNo }
