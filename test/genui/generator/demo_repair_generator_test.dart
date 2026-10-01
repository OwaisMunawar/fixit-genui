import 'dart:typed_data';

import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/generator/demo/demo_repair_generator.dart';
import 'package:fixit/genui/generator/demo/demo_scripts.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/guardrails/safety_guardrail.dart';
import 'package:fixit/genui/pipeline/turn_pipeline.dart';
import 'package:flutter_test/flutter_test.dart';

const generator = DemoRepairGenerator(latency: Duration.zero);
final pipeline = TurnPipeline(catalog: FixitCatalog.catalog);

AnswersInput answers(Map<String, Object?> values) => AnswersInput(
  surfaceId: 't0-0',
  componentId: 'questions',
  formTitle: 'Questions',
  answers: values,
  summary: const [],
);

Future<ProcessedTurn> turn(
  String opening, {
  AnswersInput? reply,
  JobContext context = const JobContext(),
}) async {
  final request = reply == null
      ? RepairRequest(
          history: const [],
          input: TextInput(text: opening),
        )
      : RepairRequest(
          history: [
            RepairTurn(role: RepairRole.user, text: opening),
            const RepairTurn(role: RepairRole.model, text: '...'),
          ],
          input: reply,
        );
  return pipeline.process(
    await generator.generate(request),
    surfacePrefix: 't',
    context: context,
  );
}

List<String> typesIn(ProcessedTurn turn) => [
  for (final c in turn.surfaces.single.components) c['component']! as String,
];

void main() {
  group('scripted answers are valid model output', () {
    final cases = <String, List<Map<String, Object?>>>{
      'My kitchen faucet keeps dripping': [
        {
          'handles': 'single',
          'where': ['base', 'under'],
          'shutoff': false,
        },
        {'handles': 'double', 'where': <String>[], 'shutoff': true},
      ],
      'The kitchen breaker keeps tripping': [
        {'immediate': false, 'smell': false, 'age': 35},
        {'immediate': true, 'smell': false},
      ],
      'A bathroom floor tile cracked': [
        {'location': 'shower', 'count': 5, 'hollow': true, 'spare': true},
        {'location': 'floor', 'count': 1, 'hollow': false, 'spare': false},
      ],
    };

    for (final MapEntry(key: opening, value: replies) in cases.entries) {
      test(opening, () async {
        final first = await turn(opening);
        expect(first.issues, isEmpty);
        expect(typesIn(first), contains('QuestionForm'));

        for (final reply in replies) {
          final second = await turn(opening, reply: answers(reply));
          expect(second.issues, isEmpty, reason: '$reply');
          expect(typesIn(second), contains('StepChecklist'));
        }
      });
    }
  });

  test('the breaker script relies on the guardrail for its callout', () async {
    final first = await turn(
      'The kitchen breaker keeps tripping',
      context: const JobContext(userTexts: ['breaker keeps tripping']),
    );

    expect(first.guardrail.intervened, isTrue);
    expect(
      first.surfaces.single.component(SafetyGuardrail.proCalloutId),
      isNotNull,
    );
    final banner = first.surfaces.single.component('safety')!;
    expect(banner['severity'], 'warning', reason: 'upgraded from caution');
  });

  test('unknown problems get a pointer to the samples', () async {
    final result = await turn('My fridge is humming');
    expect(result.surfaces.single.root!['title'], contains('three problems'));

    final photo = await generator.generate(
      RepairRequest(
        history: const [],
        input: TextInput(
          text: '',
          image: ImageAttachment(bytes: Uint8List.fromList([0])),
        ),
      ),
    );
    expect(photo, contains("can't look at photos"));
  });

  test('a script that has run out says so', () async {
    final request = RepairRequest(
      history: [
        const RepairTurn(role: RepairRole.user, text: 'Cracked tile'),
        for (var i = 0; i < DemoScripts.crackedTile.steps.length; i++)
          const RepairTurn(role: RepairRole.model, text: '...'),
      ],
      input: const TextInput(text: 'and now?'),
    );

    final raw = await generator.generate(request);
    expect(raw, contains('end of the demo script'));
  });

  test('matches problems by keyword', () {
    expect(DemoScripts.match('drip drip')?.id, 'leaky-faucet');
    expect(DemoScripts.match('the power went out')?.id, 'tripped-breaker');
    expect(DemoScripts.match('loose grout')?.id, 'cracked-tile');
    expect(DemoScripts.match('tape measure'), isNull);
  });

  test('waits for its latency', () async {
    const slow = DemoRepairGenerator(latency: Duration(milliseconds: 5));
    final watch = Stopwatch()..start();
    await slow.generate(
      const RepairRequest(
        history: [],
        input: TextInput(text: 'tile'),
      ),
    );
    expect(watch.elapsedMilliseconds, greaterThanOrEqualTo(5));
  });
}
