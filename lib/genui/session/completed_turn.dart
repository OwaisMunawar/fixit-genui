import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/pipeline/turn_pipeline.dart';
import 'package:flutter/foundation.dart';
import 'package:genui/genui.dart';

/// The shape of a generated checklist, extracted so the app can track job
/// progress without understanding A2UI.
@immutable
final class ChecklistOutline {
  const ChecklistOutline({
    required this.surfaceId,
    required this.componentId,
    required this.stepIds,
  });

  final String surfaceId;
  final String componentId;
  final List<String> stepIds;
}

/// One finished request/response cycle, handed to the host to persist before
/// any of it is rendered.
@immutable
final class CompletedTurn {
  const CompletedTurn({
    required this.index,
    required this.input,
    required this.rawResponse,
    required this.processed,
    required this.messages,
  });

  final int index;
  final TurnInput input;

  /// Exactly what the generator returned. Kept as model history so the next
  /// request shows the model its own words, not the repaired version.
  final String rawResponse;
  final ProcessedTurn processed;

  /// The validated, guarded A2UI messages that were rendered.
  final List<JsonMap> messages;

  List<ChecklistOutline> get checklists => [
    for (final surface in processed.surfaces)
      for (final component in surface.ofType(CatalogNames.stepChecklist))
        ChecklistOutline(
          surfaceId: surface.surfaceId,
          componentId: component['id']! as String,
          stepIds: [
            for (final step in (component['steps']! as List).cast<JsonMap>())
              step['id']! as String,
          ],
        ),
  ];
}
