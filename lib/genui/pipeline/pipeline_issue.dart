import 'package:flutter/foundation.dart';

/// Something the pipeline had to repair or discard in a model response.
///
/// Issues are logged and asserted on in tests; they are never shown to the
/// user, who only sees the degraded but working result.
enum IssueKind {
  malformedMessage,
  unrecognisedJson,
  disallowedOperation,
  orphanUpdate,
  reservedPath,
  emptySurface,
  missingId,
  unknownComponent,
  schemaViolation,
  ruleViolation,
  missingRoot,
  danglingChild,
  unreachableComponent,
  textOnlyResponse,
  emptyResponse,
}

@immutable
final class PipelineIssue {
  const PipelineIssue(
    this.kind,
    this.detail, {
    this.surfaceId,
    this.componentId,
  });

  final IssueKind kind;
  final String detail;
  final String? surfaceId;
  final String? componentId;

  @override
  String toString() =>
      '${kind.name}${componentId == null ? '' : '($componentId)'}: $detail';
}
