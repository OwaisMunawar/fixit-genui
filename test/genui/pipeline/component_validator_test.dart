import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/pipeline/component_validator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/responses.dart';

void main() {
  final validator = ComponentValidator(FixitCatalog.catalog);

  test('accepts a valid component and strips undeclared properties', () {
    final check = validator.check({...diagnosis, 'mood': 'cheerful'});

    expect(check, isA<ValidComponent>());
    expect((check as ValidComponent).component.containsKey('mood'), isFalse);
  });

  test('rejects components outside the catalog', () {
    final check = validator.check({'id': 'x', 'component': 'Carousel'});

    expect(
      check,
      isA<InvalidComponent>().having(
        (c) => c.reason,
        'reason',
        InvalidReason.notInCatalog,
      ),
    );
  });

  test('rejects schema violations', () {
    final check = validator.check({...diagnosis, 'confidence': 4});

    expect(
      check,
      isA<InvalidComponent>()
          .having((c) => c.reason, 'reason', InvalidReason.schema)
          .having((c) => c.errors, 'errors', isNotEmpty),
    );
  });

  test('rejects a missing component type', () {
    final check = validator.check({'id': 'x'});

    expect(check, isA<InvalidComponent>());
  });

  group('rules the schema cannot express', () {
    Map<String, Object?> form(List<Map<String, Object?>> questions) => {
      'id': 'q',
      'component': 'QuestionForm',
      'title': 'Questions',
      'questions': questions,
    };

    test('choice questions need two or more options', () {
      final check = validator.check(
        form([
          {
            'id': 'a',
            'label': 'Pick',
            'type': 'singleChoice',
            'options': [
              {'value': 'x', 'label': 'X'},
            ],
          },
        ]),
      );

      expect(
        check,
        isA<InvalidComponent>().having(
          (c) => c.reason,
          'reason',
          InvalidReason.rule,
        ),
      );
    });

    test('option values are unique', () {
      final check = validator.check(
        form([
          {
            'id': 'a',
            'label': 'Pick',
            'type': 'multiChoice',
            'options': [
              {'value': 'x', 'label': 'X'},
              {'value': 'x', 'label': 'Also X'},
            ],
          },
        ]),
      );

      expect(check, isA<InvalidComponent>());
    });

    test('slider bounds are ordered', () {
      final check = validator.check(
        form([
          {'id': 'a', 'label': 'How far', 'type': 'slider', 'min': 5, 'max': 1},
        ]),
      );

      expect(check, isA<InvalidComponent>());
    });

    test('question and step ids are unique', () {
      expect(
        validator.check(
          form([
            {'id': 'a', 'label': 'One', 'type': 'yesNo'},
            {'id': 'a', 'label': 'Two', 'type': 'yesNo'},
          ]),
        ),
        isA<InvalidComponent>(),
      );
      expect(
        validator.check({
          ...checklist,
          'steps': [
            {'id': 'a', 'title': 'One'},
            {'id': 'a', 'title': 'Two'},
          ],
        }),
        isA<InvalidComponent>(),
      );
    });
  });
}
