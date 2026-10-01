import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:json_schema_builder/json_schema_builder.dart';

/// Schema pieces reused across catalog items, so enums stay in sync with the
/// Dart models they parse into.
abstract final class SchemaFragments {
  static List<String> names(List<Enum> values) =>
      values.map((v) => v.name).toList();

  static Schema origin() => S.string(
    description:
        'Leave unset. Reserved for content the app adds on your behalf.',
    enumValues: names(ContentOrigin.values),
  );

  static Schema currency() => S.string(
    description: 'ISO 4217 code for every amount in this component.',
    pattern: r'^[A-Z]{3}$',
  );

  static Schema money(String description) =>
      S.number(description: description, minimum: 0, maximum: 1000000);
}
