import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/fixit_buttons.dart';
import 'package:fixit/core/ui/fixit_card.dart';
import 'package:fixit/core/ui/info_chip.dart';
import 'package:fixit/core/ui/tone.dart';
import 'package:fixit/genui/catalog/models/question_form_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';

/// What the form hands back: raw values keyed by question id for code, and a
/// readable summary for the model, which answers better to "How many handles?
/// One lever" than to `{"handles": "single"}`.
@immutable
class QuestionFormSubmission {
  const QuestionFormSubmission({required this.answers, required this.summary});

  final Map<String, Object?> answers;
  final List<String> summary;

  Map<String, Object?> toJson() => {'answers': answers, 'summary': summary};
}

class QuestionFormView extends StatefulWidget {
  const QuestionFormView({
    required this.data,
    required this.onSubmit,
    this.submittedAnswers,
    super.key,
  });

  final QuestionFormData data;
  final ValueChanged<QuestionFormSubmission> onSubmit;

  /// Non-null once the form has been answered, including after a job is
  /// reopened. The form then renders read-only.
  final Map<String, Object?>? submittedAnswers;

  @override
  State<QuestionFormView> createState() => _QuestionFormViewState();
}

class _QuestionFormViewState extends State<QuestionFormView> {
  late final Map<String, Object?> _answers = {
    for (final q in widget.data.questions) q.id: ?_initialValue(q),
    ...?widget.submittedAnswers,
  };

  bool get _isSubmitted => widget.submittedAnswers != null;

  static Object? _initialValue(Question q) {
    // A slider always has a value, so it starts answered at its midpoint
    // rather than blocking submit on a control that looks filled in.
    if (q.type != QuestionType.slider) return null;
    final min = q.min ?? 0;
    final max = q.max ?? 10;
    final step = q.step;
    final mid = min + (max - min) / 2;
    return step == null || step <= 0 ? mid : (mid / step).round() * step;
  }

  bool get _canSubmit => widget.data.questions
      .where((q) => q.required)
      .every((q) => _isAnswered(_answers[q.id]));

  static bool _isAnswered(Object? value) => switch (value) {
    null => false,
    final List<Object?> list => list.isNotEmpty,
    _ => true,
  };

  void _set(String id, Object? value) => setState(() => _answers[id] = value);

  void _submit() {
    final l10n = AppLocalizations.of(context);
    final answers = <String, Object?>{
      for (final q in widget.data.questions)
        if (_isAnswered(_answers[q.id])) q.id: _answers[q.id],
    };
    final summary = [
      for (final q in widget.data.questions)
        if (answers.containsKey(q.id))
          '${q.label} ${_display(q, answers[q.id], l10n)}',
    ];
    widget.onSubmit(QuestionFormSubmission(answers: answers, summary: summary));
  }

  static String _display(Question q, Object? value, AppLocalizations l10n) {
    String labelFor(Object? v) =>
        q.options.where((o) => o.value == v).firstOrNull?.label ?? '$v';
    return switch (q.type) {
      QuestionType.singleChoice => labelFor(value),
      QuestionType.multiChoice =>
        (value as List<Object?>? ?? const []).map(labelFor).join(', '),
      QuestionType.slider => [
        _formatNumber(value),
        if (q.unit != null) q.unit!,
      ].join(' '),
      QuestionType.yesNo => value == true ? l10n.yes : l10n.no,
    };
  }

  static String _formatNumber(Object? value) {
    if (value is! num) return '$value';
    return value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return FixitCard(
      icon: Icons.quiz_outlined,
      tone: Tone.info,
      title: widget.data.title,
      subtitle: widget.data.intro,
      trailing: _isSubmitted
          ? InfoChip(
              icon: Icons.check_rounded,
              label: l10n.answered,
              tone: Tone.success,
            )
          : null,
      footer: _isSubmitted
          ? null
          : PrimaryButton(
              label: widget.data.submitLabel ?? l10n.submitAnswers,
              icon: Icons.send_rounded,
              onPressed: _canSubmit ? _submit : null,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, question) in widget.data.questions.indexed) ...[
            if (index > 0) const SizedBox(height: Insets.lg),
            Text(question.label, style: theme.textTheme.titleSmall),
            if (question.helper != null) ...[
              const SizedBox(height: Insets.xxs),
              Text(
                question.helper!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: Insets.sm),
            _QuestionField(
              question: question,
              value: _answers[question.id],
              enabled: !_isSubmitted,
              onChanged: (value) => _set(question.id, value),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuestionField extends StatelessWidget {
  const _QuestionField({
    required this.question,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final Question question;
  final Object? value;
  final bool enabled;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (question.type) {
      QuestionType.singleChoice => Wrap(
        spacing: Insets.sm,
        runSpacing: Insets.sm,
        children: [
          for (final option in question.options)
            ChoiceChip(
              label: Text(option.label),
              selected: value == option.value,
              onSelected: enabled ? (_) => onChanged(option.value) : null,
            ),
        ],
      ),
      QuestionType.multiChoice => Wrap(
        spacing: Insets.sm,
        runSpacing: Insets.sm,
        children: [
          for (final option in question.options)
            FilterChip(
              label: Text(option.label),
              selected: _selected.contains(option.value),
              onSelected: enabled
                  ? (isOn) => onChanged(
                      isOn
                          ? [..._selected, option.value]
                          : _selected.where((v) => v != option.value).toList(),
                    )
                  : null,
            ),
        ],
      ),
      QuestionType.yesNo => SegmentedButton<bool>(
        emptySelectionAllowed: true,
        showSelectedIcon: false,
        segments: [
          ButtonSegment(value: true, label: Text(l10n.yes)),
          ButtonSegment(value: false, label: Text(l10n.no)),
        ],
        selected: {if (value is bool) value! as bool},
        onSelectionChanged: enabled
            ? (selection) =>
                  onChanged(selection.isEmpty ? null : selection.first)
            : null,
      ),
      QuestionType.slider => _SliderField(
        question: question,
        value: value is num ? (value! as num).toDouble() : null,
        enabled: enabled,
        onChanged: onChanged,
      ),
    };
  }

  List<Object?> get _selected =>
      value is List<Object?> ? value! as List<Object?> : const [];
}

class _SliderField extends StatelessWidget {
  const _SliderField({
    required this.question,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final Question question;
  final double? value;
  final bool enabled;
  final ValueChanged<Object?> onChanged;

  @override
  Widget build(BuildContext context) {
    final min = question.min ?? 0;
    final max = question.max ?? 10;
    final step = question.step;
    final divisions = step != null && step > 0
        ? ((max - min) / step).round()
        : null;
    final current = (value ?? min).clamp(min, max);
    final unit = question.unit == null ? '' : ' ${question.unit}';
    final label = '${_trim(current)}$unit';

    return Row(
      children: [
        Expanded(
          child: Slider(
            value: current,
            min: min,
            max: max,
            divisions: divisions,
            label: label,
            semanticFormatterCallback: (_) => label,
            onChanged: enabled ? onChanged : null,
          ),
        ),
        SizedBox(
          width: 88,
          child: Text(
            label,
            textAlign: TextAlign.end,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  static String _trim(double v) =>
      v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(1);
}
