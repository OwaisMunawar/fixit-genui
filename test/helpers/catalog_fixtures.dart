import 'package:fixit/genui/catalog/models/diagnosis_data.dart';
import 'package:fixit/genui/catalog/models/note_card_data.dart';
import 'package:fixit/genui/catalog/models/parts_list_data.dart';
import 'package:fixit/genui/catalog/models/pro_callout_data.dart';
import 'package:fixit/genui/catalog/models/question_form_data.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/catalog/models/safety_banner_data.dart';
import 'package:fixit/genui/catalog/models/step_checklist_data.dart';

/// Realistic payloads shared by widget and golden tests.
abstract final class CatalogFixtures {
  static const diagnosis = DiagnosisData(
    title: 'Dripping kitchen faucet',
    likelyCause: 'A worn cartridge is letting water past the closed valve.',
    summary: 'Usually fixed in under an hour.',
    confidence: 0.78,
    difficulty: Difficulty.easy,
    category: RepairCategory.plumbing,
    estimatedMinutes: 45,
    alternatives: ['Mineral build-up on the valve seat'],
  );

  static const questions = QuestionFormData(
    title: 'A few quick questions',
    intro: 'Your answers decide which part to buy.',
    submitLabel: 'Get my fix plan',
    questions: [
      Question(
        id: 'handles',
        label: 'How many handles?',
        type: QuestionType.singleChoice,
        options: [
          QuestionOption(value: 'single', label: 'One lever'),
          QuestionOption(value: 'double', label: 'Two handles'),
        ],
      ),
      Question(
        id: 'where',
        label: 'Where does it leak?',
        type: QuestionType.multiChoice,
        options: [
          QuestionOption(value: 'spout', label: 'Spout'),
          QuestionOption(value: 'base', label: 'Base'),
        ],
      ),
      Question(
        id: 'drips',
        label: 'Drips a minute',
        type: QuestionType.slider,
        min: 0,
        max: 60,
        step: 5,
        unit: 'a min',
      ),
      Question(
        id: 'shutoff',
        label: 'Shut-off valves?',
        type: QuestionType.yesNo,
      ),
    ],
  );

  static const checklist = StepChecklistData(
    title: 'Replace the cartridge',
    steps: [
      ChecklistStep(id: 'water', title: 'Turn off the water', minutes: 2),
      ChecklistStep(
        id: 'handle',
        title: 'Remove the handle',
        detail: 'Pry off the cap, then undo the screw.',
        minutes: 5,
      ),
      ChecklistStep(
        id: 'cartridge',
        title: 'Pull the cartridge',
        minutes: 10,
        safety: 'Wear eye protection if you use a puller.',
      ),
    ],
  );

  static const parts = PartsListData(
    items: [
      PartItem(
        name: 'Replacement cartridge',
        unitCost: 24,
        note: 'Match the brand',
      ),
      PartItem(name: 'O-ring', quantity: 3, unitCost: 1.5),
      PartItem(name: 'Rag'),
    ],
    tools: ['Allen key', 'Adjustable wrench'],
  );

  static const proCallout = ProCalloutData(
    title: 'Call an electrician if it keeps tripping',
    trade: 'Licensed electrician',
    reasons: ['Repeated trips can mean a failing breaker.'],
    costLow: 150,
    costHigh: 400,
    origin: ContentOrigin.guardrail,
  );

  static const banner = SafetyBannerData(
    severity: SafetySeverity.warning,
    title: 'Treat the circuit as live',
    message: 'Switch the breaker off before touching any wiring.',
  );

  static const note = NoteCardData(
    title: 'Good news',
    body: 'This is a twenty minute fix.',
  );
}
