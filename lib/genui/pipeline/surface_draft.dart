import 'package:collection/collection.dart';
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:flutter/foundation.dart';
import 'package:genui/genui.dart';

@immutable
final class DataUpdate {
  const DataUpdate({required this.path, required this.value});

  final String path;
  final Object? value;
}

/// One surface's worth of a model response, flattened out of the message
/// stream so it can be checked and repaired as a whole before anything is
/// rendered.
@immutable
final class SurfaceDraft {
  const SurfaceDraft({
    required this.surfaceId,
    required this.components,
    this.dataUpdates = const [],
  });

  static const rootId = 'root';
  static const protocolVersion = 'v0.9';

  final String surfaceId;
  final List<JsonMap> components;
  final List<DataUpdate> dataUpdates;

  JsonMap? component(String id) =>
      components.firstWhereOrNull((c) => c['id'] == id);

  JsonMap? get root => component(rootId);

  Iterable<JsonMap> ofType(String type) =>
      components.where((c) => c['component'] == type);

  bool contains(String type) => ofType(type).isNotEmpty;

  SurfaceDraft copyWith({
    List<JsonMap>? components,
    List<DataUpdate>? dataUpdates,
  }) => SurfaceDraft(
    surfaceId: surfaceId,
    components: components ?? this.components,
    dataUpdates: dataUpdates ?? this.dataUpdates,
  );

  /// Serialises back to A2UI v0.9 messages. This is also the persisted form,
  /// so a reopened job replays exactly what was rendered the first time.
  List<JsonMap> toMessages(String catalogId) => [
    {
      'version': protocolVersion,
      'createSurface': {'surfaceId': surfaceId, 'catalogId': catalogId},
    },
    {
      'version': protocolVersion,
      'updateComponents': {'surfaceId': surfaceId, 'components': components},
    },
    for (final update in dataUpdates)
      {
        'version': protocolVersion,
        'updateDataModel': {
          'surfaceId': surfaceId,
          'path': update.path,
          'value': update.value,
        },
      },
  ];
}

@immutable
final class TurnDraft {
  const TurnDraft({
    required this.surfaces,
    this.text = '',
    this.issues = const [],
  });

  final List<SurfaceDraft> surfaces;

  /// Prose the model wrote outside of any JSON block.
  final String text;
  final List<PipelineIssue> issues;

  Iterable<JsonMap> get allComponents =>
      surfaces.expand((surface) => surface.components);

  TurnDraft copyWith({
    List<SurfaceDraft>? surfaces,
    String? text,
    List<PipelineIssue>? issues,
  }) => TurnDraft(
    surfaces: surfaces ?? this.surfaces,
    text: text ?? this.text,
    issues: issues ?? this.issues,
  );
}
