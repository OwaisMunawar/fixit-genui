import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/guardrails/hazard_classifier.dart';
import 'package:fixit/genui/guardrails/safety_guardrail.dart';
import 'package:fixit/genui/pipeline/component_validator.dart';
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:fixit/genui/pipeline/response_parser.dart';
import 'package:fixit/genui/pipeline/surface_draft.dart';
import 'package:fixit/genui/pipeline/surface_sanitizer.dart';
import 'package:fixit/genui/pipeline/turn_assembler.dart';
import 'package:flutter/foundation.dart';
import 'package:genui/genui.dart';

/// Everything known about the job before this turn, used for the hazard
/// assessment. A breaker job stays an electrical job on turn three even if
/// the latest message is just "done, what next?".
@immutable
final class JobContext {
  const JobContext({
    this.userTexts = const [],
    this.diagnosedCategories = const {},
  });

  final List<String> userTexts;
  final Set<RepairCategory> diagnosedCategories;
}

@immutable
final class ProcessedTurn {
  const ProcessedTurn({
    required this.surfaces,
    required this.text,
    required this.issues,
    required this.guardrail,
    required this.diagnosedCategories,
  });

  final List<SurfaceDraft> surfaces;
  final String text;
  final List<PipelineIssue> issues;
  final GuardrailReport guardrail;
  final Set<RepairCategory> diagnosedCategories;

  List<String> get surfaceIds => [for (final s in surfaces) s.surfaceId];

  List<JsonMap> messages(String catalogId) => [
    for (final surface in surfaces) ...surface.toMessages(catalogId),
  ];
}

/// Raw model text in, render-safe surfaces out.
///
/// parse -> assemble -> validate and repair -> enforce safety. Each stage is
/// a separate class with its own tests; this only sequences them and makes
/// sure no turn ever comes out empty.
final class TurnPipeline {
  TurnPipeline({
    required Catalog catalog,
    this.classifier = const HazardClassifier(),
    this.guardrail = const SafetyGuardrail(),
    this.assembler = const TurnAssembler(),
  }) : _sanitizer = SurfaceSanitizer(ComponentValidator(catalog));

  final HazardClassifier classifier;
  final SafetyGuardrail guardrail;
  final TurnAssembler assembler;
  final SurfaceSanitizer _sanitizer;

  Future<ProcessedTurn> process(
    String raw, {
    required String surfacePrefix,
    JobContext context = const JobContext(),
  }) async {
    final parsed = await ResponseParser.parse(raw);
    var turn = assembler.assemble(parsed, surfacePrefix: surfacePrefix);
    turn = _ensureSomethingToShow(turn, surfacePrefix);

    final issues = [...turn.issues];
    final sanitized = <SurfaceDraft>[];
    for (final surface in turn.surfaces) {
      final (clean, surfaceIssues) = _sanitizer.sanitize(surface);
      sanitized.add(clean);
      issues.addAll(surfaceIssues);
    }
    turn = turn.copyWith(surfaces: sanitized, issues: issues);

    final categories = {
      ...context.diagnosedCategories,
      ...SafetyGuardrail.diagnosedCategories(turn),
    };
    final assessment = classifier.assess(
      userTexts: context.userTexts,
      diagnosedCategories: categories,
    );
    final (guarded, report) = guardrail.enforce(turn, assessment);

    for (final issue in issues) {
      genUiLogger.info('Repaired model output: $issue');
    }

    return ProcessedTurn(
      surfaces: guarded.surfaces,
      // Prose becomes a NoteCard when it is all there is, so don't show it
      // twice.
      text: turn.issues.any((i) => i.kind == IssueKind.textOnlyResponse)
          ? ''
          : guarded.text,
      issues: issues,
      guardrail: report,
      diagnosedCategories: categories,
    );
  }

  TurnDraft _ensureSomethingToShow(TurnDraft turn, String prefix) {
    if (turn.surfaces.isNotEmpty) return turn;
    final surfaceId = '$prefix-0';
    if (turn.text.isNotEmpty) {
      return turn.copyWith(
        surfaces: [TurnAssembler.noteSurface(surfaceId, turn.text)],
        issues: [
          ...turn.issues,
          const PipelineIssue(
            IssueKind.textOnlyResponse,
            'No UI in response; wrapped prose in a NoteCard',
          ),
        ],
      );
    }
    return turn.copyWith(
      surfaces: [
        TurnAssembler.noteSurface(
          surfaceId,
          SurfaceSanitizer.fallbackBody,
          isFallback: true,
        ),
      ],
      issues: [
        ...turn.issues,
        const PipelineIssue(IssueKind.emptyResponse, 'Nothing to render'),
      ],
    );
  }
}
