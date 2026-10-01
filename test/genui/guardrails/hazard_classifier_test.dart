import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/guardrails/hazard.dart';
import 'package:fixit/genui/guardrails/hazard_classifier.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const classifier = HazardClassifier();

  Set<Hazard> hazardsIn(String text) =>
      classifier.assess(userTexts: [text]).hazards;

  group('flags hazardous wording', () {
    for (final (text, hazard) in [
      ('The kitchen breaker keeps tripping', Hazard.electrical),
      ('Sparks came out of the outlet', Hazard.electrical),
      ("GFCI won't reset", Hazard.electrical),
      ('I smell gas near the stove', Hazard.gas),
      ('The pilot light keeps going out', Hazard.gas),
      ('Our CO alarm is beeping', Hazard.gas),
      ('There is a crack in the foundation', Hazard.structural),
      ('Sagging ceiling in the bedroom', Hazard.structural),
      ('Can I remove this load-bearing wall?', Hazard.structural),
    ]) {
      test('"$text" -> ${hazard.name}', () {
        expect(hazardsIn(text), contains(hazard));
      });
    }
  });

  group('ignores everyday repairs', () {
    for (final text in [
      'My kitchen faucet keeps dripping',
      'A bathroom floor tile cracked across the middle',
      'The cabinet door hinge is loose',
      'Hairline crack in the drywall paint',
    ]) {
      test('"$text"', () => expect(hazardsIn(text), isEmpty));
    }
  });

  test("trusts the model's category even without keywords", () {
    final assessment = classifier.assess(
      userTexts: ['What is this?'],
      diagnosedCategories: [RepairCategory.gas],
    );

    expect(assessment.hazards, {Hazard.gas});
    expect(assessment.minimumSeverity, SafetySeverity.danger);
  });

  test('gas outranks electrical as the primary hazard', () {
    final assessment = classifier.assess(
      userTexts: ['Gas smell and the breaker tripped'],
    );

    expect(assessment.primary, Hazard.gas);
  });

  test('a safe job has no primary hazard', () {
    expect(HazardAssessment.none.isHazardous, isFalse);
    expect(HazardAssessment.none.primary, isNull);
    expect(HazardAssessment.none.minimumSeverity, SafetySeverity.caution);
  });
}
