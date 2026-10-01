import 'dart:convert';

import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/pipeline/component_validator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/test.dart';

void main() {
  group('every catalog item', () {
    for (final item in FixitCatalog.items) {
      test('${item.name} examples satisfy the A2UI schema', () async {
        final errors = await validateCatalogItemExamples(
          item,
          FixitCatalog.catalog,
        );
        expect(errors, isEmpty);
      });

      test('${item.name} examples pass the app validator', () {
        final validator = ComponentValidator(FixitCatalog.catalog);
        for (final example in item.exampleData) {
          final components = (jsonDecode(example()) as List)
              .cast<Map<String, Object?>>();
          for (final component in components) {
            expect(validator.check(component), isA<ValidComponent>());
          }
        }
      });
    }
  });

  test('names are unique and the catalog has an id', () {
    final names = FixitCatalog.items.map((i) => i.name).toList();
    expect(names.toSet(), hasLength(names.length));
    expect(FixitCatalog.catalog.catalogId, FixitCatalog.id);
  });
}
