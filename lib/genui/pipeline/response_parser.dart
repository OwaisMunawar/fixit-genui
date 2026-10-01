import 'dart:convert';

import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:flutter/foundation.dart';
import 'package:genui/genui.dart';

@immutable
final class ParsedResponse {
  const ParsedResponse({
    required this.messages,
    required this.text,
    required this.issues,
  });

  final List<core.A2uiMessage> messages;
  final String text;
  final List<PipelineIssue> issues;
}

/// Splits raw model output into A2UI messages and prose, using genui's own
/// stream parser so the wire format matches what genui expects.
abstract final class ResponseParser {
  static Future<ParsedResponse> parse(String raw) async {
    final messages = <core.A2uiMessage>[];
    final text = StringBuffer();
    final issues = <PipelineIssue>[];

    final events = Stream.value(raw)
        .transform(const A2uiParserTransformer())
        .handleError(
          (Object error) => issues.add(
            PipelineIssue(IssueKind.malformedMessage, error.toString()),
          ),
        );

    await for (final event in events) {
      switch (event) {
        case A2uiMessageEvent(:final message):
          messages.add(message);
        case TextEvent(:final text) when _looksLikeJson(text):
          // A JSON block that isn't an A2UI message, typically a bare
          // component list. Showing it as prose would put raw JSON on screen.
          issues.add(
            PipelineIssue(IssueKind.unrecognisedJson, _truncate(text)),
          );
        case TextEvent(text: final chunk):
          text.write(chunk);
      }
    }

    return ParsedResponse(
      messages: messages,
      text: _tidy(text.toString()),
      issues: issues,
    );
  }

  static bool _looksLikeJson(String text) {
    final trimmed = text.trim();
    if (!(trimmed.startsWith('{') || trimmed.startsWith('['))) return false;
    try {
      jsonDecode(trimmed);
      return true;
    } on FormatException {
      return false;
    }
  }

  static String _tidy(String text) => text
      .replaceAll(RegExp('```(?:json)?'), '')
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();

  static String _truncate(String text) =>
      text.length <= 120 ? text : '${text.substring(0, 120)}...';
}
