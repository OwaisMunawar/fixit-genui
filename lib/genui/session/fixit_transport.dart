import 'dart:async';

import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/pipeline/turn_pipeline.dart';
import 'package:fixit/genui/session/chat_message_codec.dart';
import 'package:fixit/genui/session/completed_turn.dart';
import 'package:genui/genui.dart';

typedef TurnCommitter = Future<void> Function(CompletedTurn turn);

/// genui [Transport] that puts the validation and safety pipeline between the
/// generator and the surface controller.
///
/// genui's stock adapter streams parsed messages straight to the renderer.
/// This one buffers a whole turn first: the guardrail can only decide that a
/// ProCallout is missing once it has seen the entire answer. The cost is no
/// progressive rendering, which is the right trade for safety content.
final class FixitTransport implements Transport {
  FixitTransport({
    required this._generator,
    required this._pipeline,
    required this._catalogId,
    required this._onCommit,
  });

  final RepairGenerator _generator;
  final TurnPipeline _pipeline;
  final String _catalogId;
  final TurnCommitter _onCommit;

  final _messages = StreamController<core.A2uiMessage>.broadcast();
  final _text = StreamController<String>.broadcast();
  final _history = <RepairTurn>[];
  final _userTexts = <String>[];
  final _categories = <RepairCategory>{};
  var _turnIndex = 0;
  Future<void> _queue = Future.value();
  TurnInput? _lastFailed;

  @override
  Stream<core.A2uiMessage> get incomingMessages => _messages.stream;

  @override
  Stream<String> get incomingText => _text.stream;

  /// The input of the last request that threw, for a retry button.
  TurnInput? get lastFailedInput => _lastFailed;

  int get turnCount => _turnIndex;

  /// Rehydrates model context for a reopened job.
  void restore({
    required List<RepairTurn> history,
    required Iterable<String> userTexts,
    required Iterable<RepairCategory> categories,
    required int turnCount,
  }) {
    _history
      ..clear()
      ..addAll(history);
    _userTexts
      ..clear()
      ..addAll(userTexts);
    _categories
      ..clear()
      ..addAll(categories);
    _turnIndex = turnCount;
  }

  @override
  Future<void> sendRequest(ChatMessage message) {
    final input = ChatMessageCodec.decode(message);
    if (input == null) return Future.value();
    return send(input);
  }

  /// Requests are serialised: a form submitted while a typed message is in
  /// flight waits its turn instead of racing it for the same turn index.
  Future<void> send(TurnInput input) {
    final next = _queue.then((_) => _run(input));
    _queue = next.catchError((Object _) {});
    return next;
  }

  Future<void> _run(TurnInput input) async {
    _lastFailed = input;
    final raw = await _generator.generate(
      RepairRequest(history: List.unmodifiable(_history), input: input),
    );
    final processed = await _pipeline.process(
      raw,
      surfacePrefix: 't$_turnIndex',
      context: JobContext(
        userTexts: [
          ..._userTexts,
          if (input is TextInput) input.text,
        ],
        diagnosedCategories: {..._categories},
      ),
    );
    final messages = processed.messages(_catalogId);

    // Persist before rendering: if the app dies between the two, the reopened
    // job still has the answer the user saw.
    await _onCommit(
      CompletedTurn(
        index: _turnIndex,
        input: input,
        rawResponse: raw,
        processed: processed,
        messages: messages,
      ),
    );

    _history
      ..add(RepairTurn.fromInput(input))
      ..add(RepairTurn(role: RepairRole.model, text: raw));
    if (input is TextInput) _userTexts.add(input.text);
    _categories.addAll(processed.diagnosedCategories);
    _turnIndex++;
    _lastFailed = null;

    if (processed.text.isNotEmpty) _text.add(processed.text);
    for (final message in messages) {
      _messages.add(core.A2uiMessage.fromJson(message));
    }
  }

  @override
  void dispose() {
    unawaited(_messages.close());
    unawaited(_text.close());
  }
}
