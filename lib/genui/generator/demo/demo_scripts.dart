import 'package:fixit/genui/generator/demo/demo_response.dart';
import 'package:fixit/genui/generator/repair_request.dart';

typedef DemoStep = String Function(AnswersInput? answers);

/// A canned multi-turn conversation for one sample problem.
final class DemoScript {
  const DemoScript({
    required this.id,
    required this.pattern,
    required this.steps,
  });

  final String id;
  final RegExp pattern;
  final List<DemoStep> steps;

  bool matches(String text) => pattern.hasMatch(text);
}

extension on AnswersInput? {
  Object? operator [](String key) => this?.answers[key];

  bool isYes(String key) => this[key] == true;

  bool includes(String key, String value) =>
      (this[key] as List<Object?>? ?? const []).contains(value);

  num number(String key, {num fallback = 0}) => this[key] as num? ?? fallback;
}

abstract final class DemoScripts {
  static final List<DemoScript> all = [
    leakyFaucet,
    trippedBreaker,
    crackedTile,
  ];

  static DemoScript? match(String text) =>
      all.where((script) => script.matches(text)).firstOrNull;

  static final leakyFaucet = DemoScript(
    id: 'leaky-faucet',
    pattern: RegExp(r'\b(faucet|tap|drip\w*|leak\w*)\b', caseSensitive: false),
    steps: [
      (_) => demoResponse(
        text: 'That sounds like a worn part inside the valve.',
        components: [
          stack(['diagnosis', 'questions']),
          {
            'id': 'diagnosis',
            'component': 'DiagnosisCard',
            'title': 'Dripping kitchen faucet',
            'likelyCause':
                'A worn cartridge or O-ring is letting water past the valve '
                'when the handle is closed.',
            'summary':
                'Usually fixed in under an hour with a part from any hardware '
                'store.',
            'confidence': 0.78,
            'difficulty': 'easy',
            'category': 'plumbing',
            'estimatedMinutes': 45,
            'alternatives': [
              'Mineral build-up on the valve seat',
              'A loose packing nut on a two-handle faucet',
            ],
          },
          {
            'id': 'questions',
            'component': 'QuestionForm',
            'title': 'A few quick questions',
            'intro': 'Your answers decide which part to buy.',
            'submitLabel': 'Get my fix plan',
            'questions': [
              {
                'id': 'handles',
                'label': 'How many handles does it have?',
                'type': 'singleChoice',
                'options': [
                  {'value': 'single', 'label': 'One lever'},
                  {'value': 'double', 'label': 'Two handles'},
                ],
              },
              {
                'id': 'where',
                'label': 'Where does the water come from?',
                'type': 'multiChoice',
                'options': [
                  {'value': 'spout', 'label': 'The spout'},
                  {'value': 'base', 'label': 'Around the base'},
                  {'value': 'under', 'label': 'Under the sink'},
                ],
              },
              {
                'id': 'drips',
                'label': 'Roughly how many drips a minute?',
                'type': 'slider',
                'min': 0,
                'max': 60,
                'step': 5,
                'unit': 'a min',
              },
              {
                'id': 'shutoff',
                'label': 'Are there shut-off valves under the sink?',
                'type': 'yesNo',
              },
            ],
          },
        ],
      ),
      (answers) {
        final twoHandles = answers['handles'] == 'double';
        final noShutoff = answers['shutoff'] == false;
        final baseLeak = answers.includes('where', 'base');
        final underSink = answers.includes('where', 'under');
        final shutoff = noShutoff
            ? {
                'id': 'shutoff',
                'title': 'Turn off the main water supply',
                'detail':
                    'With no valves under the sink, close the main stop '
                    'valve, then open the faucet to drain the line.',
                'minutes': 5,
                'safety':
                    'Find the main valve before you start, in case a fitting '
                    'fails mid-job.',
              }
            : {
                'id': 'shutoff',
                'title': 'Turn off the water',
                'detail':
                    'Close both valves under the sink, then open the faucet '
                    'to drain the line.',
                'minutes': 2,
              };
        const plug = {
          'id': 'plug',
          'title': 'Plug the drain',
          'detail': "Drop a rag in the sink so small screws can't escape.",
          'minutes': 1,
        };
        const test = {
          'id': 'test',
          'title': 'Restore water and test',
          'detail':
              'Open the valves slowly and watch for drips for five '
              'minutes.',
          'minutes': 5,
        };
        final steps = twoHandles
            ? [
                shutoff,
                plug,
                {
                  'id': 'handles',
                  'title': 'Remove both handles',
                  'detail': 'Pop off the caps and undo the screws beneath.',
                  'minutes': 5,
                },
                {
                  'id': 'stems',
                  'title': 'Unscrew the valve stems',
                  'detail': 'Use an adjustable wrench on the packing nuts.',
                  'minutes': 10,
                },
                {
                  'id': 'washers',
                  'title': 'Swap the washers and O-rings',
                  'detail': 'Match the old ones by size at the store.',
                  'minutes': 10,
                },
                {
                  'id': 'seats',
                  'title': 'Check the valve seats',
                  'detail':
                      'If a seat is pitted, replace it with a seat wrench.',
                  'minutes': 10,
                  'safety':
                      "Don't force a seized seat; a cracked valve body is a "
                      'plumber job.',
                },
                test,
              ]
            : [
                shutoff,
                plug,
                {
                  'id': 'handle',
                  'title': 'Remove the handle',
                  'detail':
                      'Pry off the decorative cap, then undo the set screw '
                      'with an Allen key.',
                  'minutes': 5,
                },
                {
                  'id': 'cartridge',
                  'title': 'Pull the old cartridge',
                  'detail':
                      'Unscrew the retaining nut and lift the cartridge '
                      'straight up. Take it with you to match the new one.',
                  'minutes': 10,
                  'safety':
                      'Wear eye protection if you use a puller; corroded '
                      'parts can snap.',
                },
                if (baseLeak)
                  {
                    'id': 'spout-rings',
                    'title': 'Replace the spout O-rings',
                    'detail': 'Lift the spout off and roll on new O-rings.',
                    'minutes': 10,
                  },
                {
                  'id': 'install',
                  'title': 'Fit the new cartridge',
                  'detail':
                      'Grease the O-rings, line up the tab and reassemble in '
                      'reverse order.',
                  'minutes': 15,
                },
                test,
              ];
        if (underSink) {
          steps.insert(steps.length - 1, {
            'id': 'supply',
            'title': 'Snug the supply connections',
            'detail':
                'Tighten the nuts under the sink a quarter turn. Replace a '
                'braided hose if it is kinked or rusty.',
            'minutes': 5,
          });
        }
        return demoResponse(
          text: twoHandles
              ? "Here's the plan for a two-handle faucet."
              : "Here's the plan for a single-lever faucet.",
          components: [
            stack(['checklist', 'parts']),
            {
              'id': 'checklist',
              'component': 'StepChecklist',
              'title': twoHandles
                  ? 'Replace the washers and seats'
                  : 'Replace the cartridge',
              'steps': steps,
            },
            {
              'id': 'parts',
              'component': 'PartsList',
              'currency': 'USD',
              'items': twoHandles
                  ? [
                      {
                        'name': 'Washer and O-ring kit',
                        'quantity': 1,
                        'unitCost': 8,
                      },
                      {'name': 'Valve seats', 'quantity': 2, 'unitCost': 4.5},
                      {
                        'name': "Plumber's grease",
                        'quantity': 1,
                        'unitCost': 5,
                      },
                    ]
                  : [
                      {
                        'name': 'Replacement cartridge',
                        'quantity': 1,
                        'unitCost': 24,
                        'note': 'Match the brand stamped on the old one',
                      },
                      if (baseLeak)
                        {
                          'name': 'Spout O-ring kit',
                          'quantity': 1,
                          'unitCost': 6,
                        },
                      {
                        'name': "Plumber's grease",
                        'quantity': 1,
                        'unitCost': 5,
                      },
                    ],
              'tools': twoHandles
                  ? ['Seat wrench', 'Adjustable wrench', 'Screwdrivers']
                  : ['Allen key set', 'Adjustable wrench', 'Flat screwdriver'],
            },
          ],
        );
      },
    ],
  );

  static final trippedBreaker = DemoScript(
    id: 'tripped-breaker',
    pattern: RegExp(
      r'\b(breakers?|trip\w*|fuses?|power)\b',
      caseSensitive: false,
    ),
    steps: [
      // The scripted "model" includes a banner at too low a severity and
      // forgets the pro callout, which is exactly what the guardrail exists
      // to catch. Running the demo shows it working.
      (_) => demoResponse(
        text: "Let's work out why it's tripping.",
        components: [
          stack(['safety', 'diagnosis', 'questions']),
          {
            'id': 'safety',
            'component': 'SafetyBanner',
            'severity': 'caution',
            'title': 'Only touch the breaker handle',
            'message': 'Reset with dry hands and never remove the panel cover.',
          },
          {
            'id': 'diagnosis',
            'component': 'DiagnosisCard',
            'title': 'Overloaded kitchen circuit',
            'likelyCause':
                'A microwave and a kettle together can draw more than a '
                'kitchen circuit allows, so the breaker trips as designed.',
            'confidence': 0.64,
            'difficulty': 'moderate',
            'category': 'electrical',
            'alternatives': [
              'A worn breaker that trips below its rating',
              'A fault inside one of the appliances',
              'A loose connection at an outlet',
            ],
          },
          {
            'id': 'questions',
            'component': 'QuestionForm',
            'title': 'Help me narrow it down',
            'submitLabel': 'Check my answers',
            'questions': [
              {
                'id': 'immediate',
                'label':
                    'Does it trip again straight away, with everything '
                    'unplugged?',
                'type': 'yesNo',
              },
              {
                'id': 'smell',
                'label':
                    'Any burning smell, buzzing or scorch marks at an outlet '
                    'or the panel?',
                'type': 'yesNo',
              },
              {
                'id': 'appliances',
                'label': 'What was running when it tripped?',
                'type': 'multiChoice',
                'options': [
                  {'value': 'microwave', 'label': 'Microwave'},
                  {'value': 'kettle', 'label': 'Kettle'},
                  {'value': 'toaster', 'label': 'Toaster'},
                  {'value': 'dishwasher', 'label': 'Dishwasher'},
                ],
              },
              {
                'id': 'age',
                'label': 'Roughly how old is the panel?',
                'type': 'slider',
                'min': 0,
                'max': 50,
                'step': 5,
                'unit': 'years',
              },
            ],
          },
        ],
      ),
      (answers) {
        if (answers.isYes('immediate') || answers.isYes('smell')) {
          return demoResponse(
            text: 'That points to a fault, not an overload.',
            components: [
              stack(['danger', 'makeSafe', 'pro']),
              {
                'id': 'danger',
                'component': 'SafetyBanner',
                'severity': 'danger',
                'title': 'Leave the breaker off',
                'message':
                    'A breaker that trips with nothing plugged in, or any '
                    'burning smell, means a wiring or breaker fault. Keep it '
                    'off and call an electrician today.',
              },
              {
                'id': 'makeSafe',
                'component': 'StepChecklist',
                'title': 'Make it safe until help arrives',
                'steps': [
                  {'id': 'off', 'title': 'Leave the breaker switched off'},
                  {
                    'id': 'unplug',
                    'title': 'Unplug everything on that circuit',
                  },
                  {
                    'id': 'label',
                    'title': 'Tape a "do not reset" note on the panel',
                  },
                  {
                    'id': 'photos',
                    'title': 'Photograph any scorch marks',
                    'detail': 'It saves the electrician diagnosis time.',
                  },
                ],
              },
              {
                'id': 'pro',
                'component': 'ProCallout',
                'title': 'Call an electrician today',
                'trade': 'Licensed electrician',
                'reasons': [
                  'Tripping with no load points to a short or failing breaker.',
                  'Burning smells mean heat damage you cannot see.',
                ],
                'costLow': 150,
                'costHigh': 450,
                'currency': 'USD',
              },
            ],
          );
        }
        final oldPanel = answers.number('age') >= 30;
        return demoResponse(
          text: 'Sounds like a plain overload. Here is how to confirm it.',
          components: [
            stack(['checklist', 'parts', 'pro']),
            {
              'id': 'checklist',
              'component': 'StepChecklist',
              'title': 'Reset and rebalance the circuit',
              'steps': [
                {
                  'id': 'unplug',
                  'title': 'Unplug the high-draw appliances',
                  'detail': 'Microwave, kettle and toaster first.',
                  'minutes': 2,
                },
                {
                  'id': 'reset',
                  'title': 'Reset the breaker firmly',
                  'detail':
                      'Push it fully to OFF, then back to ON. A tripped '
                      'breaker often rests in the middle.',
                  'minutes': 2,
                  'safety':
                      'Stand on a dry floor and touch only the handle. Never '
                      'open the panel cover.',
                },
                {
                  'id': 'one-at-a-time',
                  'title': 'Add appliances back one at a time',
                  'detail': 'Note which combination trips it.',
                  'minutes': 10,
                },
                {
                  'id': 'split',
                  'title': 'Split the load',
                  'detail':
                      'Run the kettle from an outlet on a different circuit. '
                      'An outlet tester shows which outlets share a breaker.',
                  'minutes': 10,
                },
                {
                  'id': 'watch',
                  'title': 'Watch it for a week',
                  'detail':
                      'If it trips with normal use, the breaker or wiring '
                      'needs a professional look.',
                },
              ],
            },
            {
              'id': 'parts',
              'component': 'PartsList',
              'title': 'Handy to have',
              'currency': 'USD',
              'items': [
                {
                  'name': 'Plug-in outlet tester',
                  'quantity': 1,
                  'unitCost': 12,
                },
                {
                  'name': 'Non-contact voltage tester',
                  'quantity': 1,
                  'unitCost': 20,
                },
              ],
            },
            {
              'id': 'pro',
              'component': 'ProCallout',
              'title': oldPanel
                  ? 'Have an older panel inspected'
                  : 'Call an electrician if it keeps tripping',
              'trade': 'Licensed electrician',
              'reasons': [
                if (oldPanel)
                  'Panels over 30 years old often have worn breakers.',
                'A kitchen may need a dedicated circuit for the microwave.',
              ],
              'costLow': 150,
              'costHigh': 400,
              'currency': 'USD',
            },
          ],
        );
      },
    ],
  );

  static final crackedTile = DemoScript(
    id: 'cracked-tile',
    pattern: RegExp(r'\b(tiles?|grout)\b', caseSensitive: false),
    steps: [
      (_) => demoResponse(
        text: 'A single cracked tile is a very doable fix.',
        components: [
          stack(['diagnosis', 'questions']),
          {
            'id': 'diagnosis',
            'component': 'DiagnosisCard',
            'title': 'Cracked floor tile',
            'likelyCause':
                'A hollow spot in the mortar under the tile let it flex '
                'until it cracked.',
            'confidence': 0.7,
            'difficulty': 'moderate',
            'category': 'flooring',
            'estimatedMinutes': 120,
            'alternatives': [
              'Something heavy was dropped on it',
              'Subfloor movement, if several tiles are cracking',
            ],
          },
          {
            'id': 'questions',
            'component': 'QuestionForm',
            'title': 'Before you pick up a chisel',
            'questions': [
              {
                'id': 'location',
                'label': 'Where is the tile?',
                'type': 'singleChoice',
                'options': [
                  {'value': 'floor', 'label': 'Floor'},
                  {'value': 'wall', 'label': 'Wall'},
                  {'value': 'shower', 'label': 'Inside the shower'},
                ],
              },
              {
                'id': 'count',
                'label': 'How many tiles are cracked?',
                'type': 'slider',
                'min': 1,
                'max': 10,
                'step': 1,
                'unit': 'tiles',
              },
              {
                'id': 'hollow',
                'label': 'Do nearby tiles sound hollow when tapped?',
                'type': 'yesNo',
              },
              {
                'id': 'spare',
                'label': 'Do you have a spare tile from the original job?',
                'type': 'yesNo',
              },
            ],
          },
        ],
      ),
      (answers) {
        final shower = answers['location'] == 'shower';
        final widespread =
            answers.number('count', fallback: 1) >= 4 ||
            answers.isYes('hollow');
        final hasSpare = answers.isYes('spare');
        return demoResponse(
          text: "Here's how to swap it out cleanly.",
          components: [
            stack([if (widespread) 'subfloor', 'checklist', 'parts']),
            if (widespread)
              {
                'id': 'subfloor',
                'component': 'NoteCard',
                'tone': 'warning',
                'title': 'Keep an eye on the floor',
                'body':
                    'Several cracked or hollow tiles can mean the subfloor is '
                    'flexing. Replace this one, but have the floor checked if '
                    'more start to crack.',
              },
            {
              'id': 'checklist',
              'component': 'StepChecklist',
              'title': 'Replace the cracked tile',
              'steps': [
                {
                  'id': 'protect',
                  'title': 'Protect the area',
                  'detail': 'Tape the edges of the neighbouring tiles.',
                  'minutes': 5,
                  'safety':
                      'Wear safety glasses and gloves; tile shards are sharp.',
                },
                {
                  'id': 'grout',
                  'title': 'Cut out the grout',
                  'detail': 'Work a grout saw all the way round the tile.',
                  'minutes': 20,
                },
                {
                  'id': 'break',
                  'title': 'Break out the tile',
                  'detail':
                      'Score an X, then tap from the centre outwards with a '
                      'chisel.',
                  'minutes': 20,
                  'safety':
                      "Work from the centre so you don't chip the tiles "
                      'around it.',
                },
                {
                  'id': 'scrape',
                  'title': 'Scrape off the old mortar',
                  'minutes': 25,
                },
                {
                  'id': 'set',
                  'title': 'Set the new tile',
                  'detail':
                      'Back-butter it and press it level with its '
                      'neighbours.',
                  'minutes': 15,
                },
                {
                  'id': 'cure',
                  'title': 'Let it cure for 24 hours',
                  'detail': 'Keep foot traffic off it.',
                },
                {
                  'id': 'regrout',
                  'title': 'Grout and seal',
                  'minutes': 20,
                  if (shower)
                    'safety':
                        'Use waterproof grout and wait 72 hours before '
                        'showering.',
                },
              ],
            },
            {
              'id': 'parts',
              'component': 'PartsList',
              'currency': 'USD',
              'items': [
                if (hasSpare)
                  {
                    'name': 'Spare tile',
                    'quantity': 1,
                    'note': 'From the original install',
                  }
                else
                  {
                    'name': 'Matching tile',
                    'quantity': 2,
                    'unitCost': 8,
                    'note': 'Take a broken piece to the store',
                  },
                {
                  'name': 'Thin-set mortar, small bag',
                  'quantity': 1,
                  'unitCost': 15,
                },
                {
                  'name': shower ? 'Waterproof grout' : 'Colour-matched grout',
                  'quantity': 1,
                  'unitCost': shower ? 22 : 12,
                },
                {'name': 'Grout sealer', 'quantity': 1, 'unitCost': 10},
              ],
              'tools': [
                'Grout saw',
                'Cold chisel',
                'Hammer',
                'Notched trowel',
                'Rubber float',
                'Safety glasses',
              ],
            },
          ],
        );
      },
    ],
  );

  static String unknownProblem({required bool hasPhoto}) => demoResponse(
    components: [
      {
        'id': 'root',
        'component': 'NoteCard',
        'title': 'Demo mode knows three problems',
        'body': hasPhoto
            ? "Demo answers are scripted, so I can't look at photos yet. Try "
                  'a leaky faucet, a tripped breaker or a cracked tile, or '
                  'run with a GEMINI_API_KEY to ask about anything.'
            : 'Try a leaky faucet, a tripped breaker or a cracked tile, or '
                  'run with a GEMINI_API_KEY to ask about anything.',
      },
    ],
  );

  static String endOfScript() => demoResponse(
    components: [
      {
        'id': 'root',
        'component': 'NoteCard',
        'title': "That's the end of the demo script",
        'body':
            'Tick off the steps as you go; progress is saved with the job. '
            'With a GEMINI_API_KEY, Fixit keeps answering follow-ups.',
      },
    ],
  );
}
