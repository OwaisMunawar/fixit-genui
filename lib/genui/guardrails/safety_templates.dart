import 'package:fixit/genui/guardrails/hazard.dart';

/// The copy the guardrail injects when the model leaves safety content out.
///
/// Written once, reviewed once, and identical every time: this is the one
/// part of an answer that should never depend on how the model felt that day.
/// Costs are deliberately wide call-out ranges, not quotes.
abstract final class SafetyTemplates {
  static ({String title, String message}) banner(Hazard hazard) =>
      switch (hazard) {
        Hazard.gas => (
          title: 'If you smell gas, leave first',
          message:
              "Don't switch anything on or off or use a flame. Get everyone "
              "outside, then call your gas supplier's emergency line from a "
              'safe distance.',
        ),
        Hazard.electrical => (
          title: 'Treat the circuit as live',
          message:
              'Switch the breaker off before touching outlets, switches or '
              'wiring, and confirm with a non-contact tester. If you see '
              'scorch marks or smell burning, stop and call an electrician.',
        ),
        Hazard.structural => (
          title: 'Keep weight off the damaged area',
          message:
              "Don't load, cut or remove anything that may be load-bearing "
              'until it has been assessed. Movement can get worse quickly.',
        ),
      };

  static ({
    String title,
    String trade,
    List<String> reasons,
    double costLow,
    double costHigh,
  })
  proCallout(Hazard hazard) => switch (hazard) {
    Hazard.gas => (
      title: 'Have a gas engineer inspect it',
      trade: 'Licensed gas fitter',
      reasons: [
        'Gas faults can cause fire, explosion or carbon monoxide poisoning.',
        'Gas work legally requires a licensed professional in most places.',
      ],
      costLow: 120,
      costHigh: 450,
    ),
    Hazard.electrical => (
      title: 'Bring in an electrician if it persists',
      trade: 'Licensed electrician',
      reasons: [
        'Repeated trips can mean a failing breaker or loose wiring.',
        'Panel and wiring work usually needs a licence and often a permit.',
      ],
      costLow: 150,
      costHigh: 400,
    ),
    Hazard.structural => (
      title: 'Get a structural assessment',
      trade: 'Structural engineer',
      reasons: [
        'The right fix depends on the cause, which needs an on-site look.',
        'Structural repairs often need sign-off before work starts.',
      ],
      costLow: 300,
      costHigh: 800,
    ),
  };
}
