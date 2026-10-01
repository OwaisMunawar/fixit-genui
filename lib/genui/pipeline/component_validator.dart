import 'package:fixit/genui/pipeline/component_rules.dart';
import 'package:genui/genui.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

sealed class ComponentCheck {
  const ComponentCheck();
}

/// Passed validation. [component] has unknown properties stripped, because
/// genui's own post-render validation rejects anything the schema doesn't
/// declare.
final class ValidComponent extends ComponentCheck {
  const ValidComponent(this.component);

  final JsonMap component;
}

enum InvalidReason { notInCatalog, schema, rule }

final class InvalidComponent extends ComponentCheck {
  const InvalidComponent({
    required this.id,
    required this.type,
    required this.reason,
    required this.errors,
    required this.original,
  });

  final String id;
  final String? type;
  final InvalidReason reason;
  final List<String> errors;
  final JsonMap original;
}

/// Validates single components against the schema of their catalog item.
final class ComponentValidator {
  ComponentValidator(Catalog catalog)
    : _schemas = {for (final item in catalog.items) item.name: item.dataSchema};

  static const _envelopeKeys = {'id', 'component', 'accessibility'};

  final Map<String, ObjectSchema> _schemas;

  bool knows(String type) => _schemas.containsKey(type);

  ComponentCheck check(JsonMap component) {
    final id = component['id']! as String;
    final type = component['component'];
    if (type is! String) {
      return InvalidComponent(
        id: id,
        type: null,
        reason: InvalidReason.schema,
        errors: const ['Missing "component" type'],
        original: component,
      );
    }
    final schema = _schemas[type];
    if (schema == null) {
      return InvalidComponent(
        id: id,
        type: type,
        reason: InvalidReason.notInCatalog,
        errors: ['"$type" is not in the catalog'],
        original: component,
      );
    }

    final cleaned = _stripUnknown(component, schema);
    final schemaErrors = schema
        .validateSync(cleaned)
        .map((error) => error.toErrorString())
        .toList();
    if (schemaErrors.isNotEmpty) {
      return InvalidComponent(
        id: id,
        type: type,
        reason: InvalidReason.schema,
        errors: schemaErrors,
        original: component,
      );
    }
    final ruleErrors = ComponentRules.check(type, cleaned);
    if (ruleErrors.isNotEmpty) {
      return InvalidComponent(
        id: id,
        type: type,
        reason: InvalidReason.rule,
        errors: ruleErrors,
        original: component,
      );
    }
    return ValidComponent(cleaned);
  }

  static JsonMap _stripUnknown(JsonMap component, ObjectSchema schema) {
    final declared = schema.properties?.keys.toSet() ?? const <String>{};
    return {
      for (final entry in component.entries)
        if (_envelopeKeys.contains(entry.key) || declared.contains(entry.key))
          entry.key: entry.value,
    };
  }
}
