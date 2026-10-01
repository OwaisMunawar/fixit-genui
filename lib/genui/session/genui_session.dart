import 'dart:async';

import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/pipeline/turn_pipeline.dart';
import 'package:fixit/genui/session/chat_message_codec.dart';
import 'package:fixit/genui/session/fixit_transport.dart';
import 'package:flutter/foundation.dart';
import 'package:genui/genui.dart';

/// Ticked steps for one generated checklist.
@immutable
final class ChecklistState {
  const ChecklistState({
    required this.surfaceId,
    required this.componentId,
    required this.completed,
  });

  final String surfaceId;
  final String componentId;
  final Set<String> completed;
}

/// Answers submitted to one generated question form.
@immutable
final class FormAnswersState {
  const FormAnswersState({
    required this.surfaceId,
    required this.componentId,
    required this.answers,
  });

  final String surfaceId;
  final String componentId;
  final Map<String, Object?> answers;
}

@immutable
final class SessionSnapshot {
  const SessionSnapshot({
    required this.history,
    required this.userTexts,
    required this.categories,
    required this.turnCount,
    required this.messages,
    this.checklists = const [],
    this.formAnswers = const [],
  });

  final List<RepairTurn> history;
  final List<String> userTexts;
  final Set<RepairCategory> categories;
  final int turnCount;

  /// Every rendered A2UI message for the job, in order.
  final List<JsonMap> messages;

  final List<ChecklistState> checklists;
  final List<FormAnswersState> formAnswers;
}

/// The one place the app touches genui's runtime.
///
/// It owns the [SurfaceController], the [FixitTransport] and genui's
/// [Conversation] facade. Upgrading genui, or replacing it, means changing
/// this file and the catalog items, nothing in `features/`.
final class GenUiSession {
  GenUiSession({
    required RepairGenerator generator,
    required TurnCommitter onCommit,
    Catalog? catalog,
    TurnPipeline? pipeline,
  }) : catalog = catalog ?? FixitCatalog.catalog {
    controller = SurfaceController(catalogs: [this.catalog]);
    transport = FixitTransport(
      generator: generator,
      pipeline: pipeline ?? TurnPipeline(catalog: this.catalog),
      catalogId: this.catalog.catalogId!,
      onCommit: onCommit,
    );
    conversation = Conversation(controller: controller, transport: transport);
  }

  final Catalog catalog;
  late final SurfaceController controller;
  late final FixitTransport transport;
  late final Conversation conversation;

  Stream<ConversationEvent> get events => conversation.events;

  ValueListenable<ConversationState> get state => conversation.state;

  TurnInput? get lastFailedInput => transport.lastFailedInput;

  Future<void> send(TurnInput input) =>
      conversation.sendRequest(ChatMessageCodec.encode(input));

  Future<void> retry() async {
    final input = transport.lastFailedInput;
    if (input != null) await send(input);
  }

  SurfaceContext surfaceContext(String surfaceId) =>
      controller.contextFor(surfaceId);

  /// Replays a saved job: surfaces first, then the widget state that lives in
  /// each surface's data model, then the model's conversation context.
  void restore(SessionSnapshot snapshot) {
    for (final message in snapshot.messages) {
      controller.handleMessage(core.A2uiMessage.fromJson(message));
    }
    final live = controller.activeSurfaceIds.toSet();
    void write(String surfaceId, String path, Object value) {
      // A surface can be missing if its saved messages no longer validate
      // against the current catalog; skip its state rather than throw.
      if (!live.contains(surfaceId)) return;
      controller.contextFor(surfaceId).dataModel.update(DataPath(path), value);
    }

    for (final state in snapshot.checklists) {
      write(
        state.surfaceId,
        FixitDataPaths.checklist(state.componentId),
        state.completed.toList(),
      );
    }
    for (final state in snapshot.formAnswers) {
      write(
        state.surfaceId,
        FixitDataPaths.formAnswers(state.componentId),
        {...state.answers},
      );
    }
    transport.restore(
      history: snapshot.history,
      userTexts: snapshot.userTexts,
      categories: snapshot.categories,
      turnCount: snapshot.turnCount,
    );
  }

  void dispose() {
    conversation.dispose();
    transport.dispose();
    controller.dispose();
  }
}
