import 'package:fixit/genui/generator/repair_request.dart';

/// Produces a model response for one turn of a repair job.
///
/// The response is raw text in the A2UI wire format: prose and fenced JSON
/// messages. Every implementation shares the same parsing, validation and
/// guardrail pipeline downstream, which is what makes demo mode a faithful
/// stand-in for the real model.
///
/// Implementations throw an `AppFailure` for anything the user should see.
abstract interface class RepairGenerator {
  Future<String> generate(RepairRequest request);
}
