import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/guardrails/hazard.dart';

/// Decides whether a job is hazardous from two independent signals: what the
/// user wrote and how the model categorised it.
///
/// Either one is enough. Relying only on the model's category would let a
/// miscategorised gas smell through; relying only on keywords would miss a
/// photo of scorched outlet with the caption "what is this?".
///
/// Patterns are deliberately conservative on structure ("crack" alone would
/// flag every cracked tile) and generous on gas, where a false positive costs
/// a banner and a false negative costs far more.
final class HazardClassifier {
  const HazardClassifier();

  static final _patterns = <Hazard, RegExp>{
    Hazard.gas: RegExp(
      r'\b(gas|propane|butane|pilot light|rotten eggs?|carbon monoxide|'
      r'co alarm|co detector)\b',
      caseSensitive: false,
    ),
    Hazard.electrical: RegExp(
      r'\b(breakers?|circuits?|outlets?|sockets?|receptacles?|wiring|wires?|'
      'fuses?|fuse ?box|consumer unit|gfci|gfi|rcd|electrical|electric shock|'
      r'shocked|sparks?|sparking|scorch(ed)?|voltage|light switch(es)?)\b',
      caseSensitive: false,
    ),
    Hazard.structural: RegExp(
      r'\b(load[- ]bearing|foundations?|joists?|beams?|rafters?|subsidence|'
      'structural|bowing (wall|ceiling)|sagging (ceiling|floor|roof|beam)|'
      r'crack(s|ed)? in (the )?(foundation|load[- ]bearing wall))\b',
      caseSensitive: false,
    ),
  };

  HazardAssessment assess({
    required Iterable<String> userTexts,
    Iterable<RepairCategory> diagnosedCategories = const [],
  }) {
    final hazards = <Hazard>{
      ...diagnosedCategories.map(Hazard.fromCategory).nonNulls,
    };
    final corpus = userTexts.join('\n');
    for (final MapEntry(key: hazard, value: pattern) in _patterns.entries) {
      if (pattern.hasMatch(corpus)) hazards.add(hazard);
    }
    return HazardAssessment(hazards);
  }
}
