import 'dart:async';

import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/catalog/models/repair_enums.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/generator/repair_request.dart';
import 'package:fixit/genui/pipeline/turn_pipeline.dart';
import 'package:fixit/genui/session/chat_message_codec.dart';
import 'package:fixit/genui/session/completed_turn.dart';
import 'package:fixit/genui/session/fixit_transport.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fakes.dart';
import '../../helpers/responses.dart';

void main() {
  late QueuedGenerator generator;
  late List<CompletedTurn> committed;
  late FixitTransport transport;

  setUp(() {
    generator = QueuedGenerator();
    committed = [];
    transport = FixitTransport(
      generator: generator,
      pipeline: TurnPipeline(catalog: FixitCatalog.catalog),
      catalogId: FixitCatalog.id,
      onCommit: (turn) async => committed.add(turn),
    );
  });

  tearDown(() => transport.dispose());

  test('commits a turn before emitting its messages', () async {
    generator.enqueue(rawResponse([diagnosis], text: 'Hi'));
    final order = <String>[];
    final sub = transport.incomingMessages.listen((m) {
      order.add(committed.isEmpty ? 'message-first' : 'commit-first');
    });

    await transport.send(const TextInput(text: 'drip'));
    await pumpEventQueue();

    expect(order, everyElement('commit-first'));
    expect(committed.single.index, 0);
    expect(committed.single.checklists, isEmpty);
    await sub.cancel();
  });

  test('builds history across turns for a stateless model', () async {
    generator
      ..enqueue(rawResponse([diagnosis]))
      ..enqueue(rawResponse([checklist]));

    await transport.send(const TextInput(text: 'drip'));
    await transport.send(const TextInput(text: 'next'));

    final second = generator.requests.last;
    expect(second.history.map((t) => t.role), [
      RepairRole.user,
      RepairRole.model,
    ]);
    expect(second.history.first.text, 'drip');
    expect(committed.last.processed.surfaceIds, ['t1-0']);
    expect(committed.last.checklists.single.stepIds, ['a', 'b']);
  });

  test('serialises concurrent requests', () async {
    final gate = Completer<void>();
    final slow = _GatedGenerator(gate, rawResponse([diagnosis]));
    final serial = FixitTransport(
      generator: slow,
      pipeline: TurnPipeline(catalog: FixitCatalog.catalog),
      catalogId: FixitCatalog.id,
      onCommit: (turn) async => committed.add(turn),
    );

    final first = serial.send(const TextInput(text: 'one'));
    final second = serial.send(const TextInput(text: 'two'));
    await pumpEventQueue();
    expect(slow.calls, 1);

    gate.complete();
    await Future.wait([first, second]);
    expect(committed.map((t) => t.index), [0, 1]);
    serial.dispose();
  });

  test('remembers the failed input for a retry', () async {
    generator.enqueue(const RateLimitedFailure());

    await expectLater(
      transport.send(const TextInput(text: 'drip')),
      throwsA(isA<RateLimitedFailure>()),
    );
    expect((transport.lastFailedInput! as TextInput).text, 'drip');
    expect(transport.turnCount, 0);

    generator.enqueue(rawResponse([diagnosis]));
    await transport.send(transport.lastFailedInput!);
    expect(transport.lastFailedInput, isNull);
    expect(transport.turnCount, 1);
  });

  test('a later failed request does not block the queue', () async {
    generator
      ..enqueue(const OfflineFailure())
      ..enqueue(rawResponse([diagnosis]));

    await expectLater(
      transport.send(const TextInput(text: 'a')),
      throwsA(isA<OfflineFailure>()),
    );
    await transport.send(const TextInput(text: 'b'));
    expect(committed, hasLength(1));
  });

  test('restored context drives the hazard check', () async {
    transport.restore(
      history: const [RepairTurn(role: RepairRole.user, text: 'old')],
      userTexts: const ['The breaker trips'],
      categories: const {RepairCategory.electrical},
      turnCount: 2,
    );
    generator.enqueue(rawResponse([checklist]));

    await transport.send(const TextInput(text: 'done, now what?'));

    expect(committed.single.index, 2);
    expect(committed.single.processed.guardrail.intervened, isTrue);
  });

  test('drops messages genui generates for itself', () async {
    final error = ChatMessageCodec.encode(const TextInput(text: ''));
    await transport.sendRequest(error);
    expect(generator.requests, isEmpty);
  });

  test('re-emits every rendered message as an A2UI message', () async {
    generator.enqueue(rawResponse([diagnosis], text: 'Note'));
    final messages = <core.A2uiMessage>[];
    final texts = <String>[];
    final subs = [
      transport.incomingMessages.listen(messages.add),
      transport.incomingText.listen(texts.add),
    ];

    await transport.sendRequest(
      ChatMessageCodec.encode(const TextInput(text: 'drip')),
    );
    await pumpEventQueue();

    expect(messages.whereType<core.CreateSurfaceMessage>(), hasLength(1));
    expect(texts, ['Note']);
    for (final sub in subs) {
      await sub.cancel();
    }
  });
}

final class _GatedGenerator implements RepairGenerator {
  _GatedGenerator(this.gate, this.response);

  final Completer<void> gate;
  final String response;
  int calls = 0;

  @override
  Future<String> generate(RepairRequest request) async {
    calls++;
    await gate.future;
    return response;
  }
}
