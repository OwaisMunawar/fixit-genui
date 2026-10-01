import 'dart:convert';

import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:genui/genui.dart';

/// Formats a scripted answer exactly the way the model is asked to: optional
/// prose followed by fenced A2UI JSON messages. Scripts therefore exercise
/// the same parser, validator and guardrail as a live response.
String demoResponse({required List<JsonMap> components, String? text}) {
  const surfaceId = 'answer';
  final create = {
    'version': 'v0.9',
    'createSurface': {'surfaceId': surfaceId, 'catalogId': FixitCatalog.id},
  };
  final update = {
    'version': 'v0.9',
    'updateComponents': {'surfaceId': surfaceId, 'components': components},
  };
  const encoder = JsonEncoder.withIndent('  ');
  return [
    ?text,
    '```json\n${encoder.convert(create)}\n```',
    '```json\n${encoder.convert(update)}\n```',
  ].join('\n\n');
}

JsonMap stack(List<String> children) => {
  'id': 'root',
  'component': 'ResponseStack',
  'children': children,
};
