import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:genui/genui.dart';

/// Checks JSON Schema cannot express, such as "choice questions need options"
/// or "ids are unique within a list".
abstract final class ComponentRules {
  static List<String> check(String type, JsonMap json) => switch (type) {
    CatalogNames.questionForm => _questionForm(json),
    CatalogNames.stepChecklist => _uniqueIds(json['steps'], 'step'),
    _ => const [],
  };

  static List<String> _questionForm(JsonMap json) {
    final questions = json['questions'];
    if (questions is! List) return const [];
    final errors = [..._uniqueIds(questions, 'question')];
    for (final question in questions.whereType<Map<String, Object?>>()) {
      final id = question['id'];
      final type = question['type'];
      if (type == 'singleChoice' || type == 'multiChoice') {
        final options = question['options'];
        final values = options is List
            ? options.whereType<Map<String, Object?>>().map((o) => o['value'])
            : const <Object?>[];
        if (values.length < 2) {
          errors.add('Question "$id" needs at least two options');
        } else if (values.toSet().length != values.length) {
          errors.add('Question "$id" has duplicate option values');
        }
      }
      if (type == 'slider') {
        final min = question['min'];
        final max = question['max'];
        if (min is num && max is num && min >= max) {
          errors.add('Question "$id" has min >= max');
        }
      }
    }
    return errors;
  }

  static List<String> _uniqueIds(Object? list, String label) {
    if (list is! List) return const [];
    final ids = list
        .whereType<Map<String, Object?>>()
        .map((item) => item['id'])
        .toList();
    return ids.toSet().length == ids.length
        ? const []
        : ['Duplicate $label ids'];
  }
}
