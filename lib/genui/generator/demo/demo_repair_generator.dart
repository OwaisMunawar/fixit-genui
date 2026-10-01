import 'package:fixit/genui/generator/demo/demo_scripts.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/generator/repair_request.dart';

/// Deterministic generator for demo mode: no key, no network, same UI.
///
/// The script is chosen from the job's first message and advanced by the
/// number of answers already given, so a reopened job continues where it
/// left off.
final class DemoRepairGenerator implements RepairGenerator {
  const DemoRepairGenerator({
    this.latency = const Duration(milliseconds: 700),
  });

  /// A short pause so the loading state is visible and the demo feels like
  /// the real thing. Zero in tests.
  final Duration latency;

  @override
  Future<String> generate(RepairRequest request) async {
    if (latency > Duration.zero) await Future<void>.delayed(latency);

    final firstUserTurn = request.history
        .where((turn) => turn.role == RepairRole.user)
        .firstOrNull;
    final opening = firstUserTurn?.text ?? request.input.promptText;
    final script = DemoScripts.match(opening);
    if (script == null) {
      final hasPhoto = switch (request.input) {
        TextInput(:final image) => image != null,
        AnswersInput() => false,
      };
      return DemoScripts.unknownProblem(hasPhoto: hasPhoto);
    }

    final step = request.completedModelTurns;
    if (step >= script.steps.length) return DemoScripts.endOfScript();
    final answers = switch (request.input) {
      final AnswersInput answers => answers,
      TextInput() => null,
    };
    return script.steps[step](answers);
  }
}
