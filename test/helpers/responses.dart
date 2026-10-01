import 'dart:convert';

import 'package:fixit/genui/catalog/fixit_catalog.dart';

/// Builds model-shaped raw text: prose followed by fenced A2UI messages.
String rawResponse(
  List<Map<String, Object?>> components, {
  String surfaceId = 'main',
  String? text,
  bool includeCreate = true,
}) {
  final blocks = [
    if (includeCreate)
      {
        'version': 'v0.9',
        'createSurface': {'surfaceId': surfaceId, 'catalogId': FixitCatalog.id},
      },
    {
      'version': 'v0.9',
      'updateComponents': {'surfaceId': surfaceId, 'components': components},
    },
  ];
  return [
    ?text,
    for (final block in blocks) '```json\n${jsonEncode(block)}\n```',
  ].join('\n');
}

Map<String, Object?> stackOf(List<String> children) => {
  'id': 'root',
  'component': 'ResponseStack',
  'children': children,
};

const Map<String, Object?> diagnosis = {
  'id': 'diagnosis',
  'component': 'DiagnosisCard',
  'title': 'Dripping faucet',
  'likelyCause': 'A worn cartridge.',
  'confidence': 0.8,
  'difficulty': 'easy',
  'category': 'plumbing',
};

const Map<String, Object?> electricalDiagnosis = {
  'id': 'diagnosis',
  'component': 'DiagnosisCard',
  'title': 'Dead outlet',
  'likelyCause': 'A tripped GFCI upstream.',
  'confidence': 0.6,
  'difficulty': 'moderate',
  'category': 'electrical',
};

const Map<String, Object?> checklist = {
  'id': 'checklist',
  'component': 'StepChecklist',
  'title': 'Fix it',
  'steps': [
    {'id': 'a', 'title': 'First'},
    {'id': 'b', 'title': 'Second'},
  ],
};
