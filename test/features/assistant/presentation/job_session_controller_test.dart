import 'dart:typed_data';

import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/features/assistant/domain/picked_photo.dart';
import 'package:fixit/features/assistant/presentation/job_session_controller.dart';
import 'package:fixit/features/assistant/presentation/job_session_state.dart';
import 'package:fixit/features/jobs/data/database/app_database.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:fixit/features/jobs/jobs_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/app_overrides.dart';
import '../../../helpers/fakes.dart';
import '../../../helpers/responses.dart';

void main() {
  late AppDatabase db;
  late QueuedGenerator generator;
  late MemoryPhotoStore photos;

  setUp(() {
    db = memoryDatabase();
    generator = QueuedGenerator();
    photos = MemoryPhotoStore();
  });

  tearDown(() => db.close());

  ProviderContainer container() => ProviderContainer.test(
    overrides: appOverrides(
      db: db,
      generator: generator,
      photos: photos,
      clock: () => DateTime(2026, 10),
    ),
  );

  Future<JobSessionController> open(ProviderContainer c, String id) async {
    c.listen(jobSessionControllerProvider(id), (_, _) {});
    await pumpEventQueue();
    expect(c.read(jobSessionControllerProvider(id)).isLoading, isFalse);
    return c.read(jobSessionControllerProvider(id).notifier);
  }

  JobSessionState stateOf(ProviderContainer c, String id) =>
      c.read(jobSessionControllerProvider(id));

  test('an unknown job id opens as a draft', () async {
    final c = container();
    await open(c, 'new');

    expect(stateOf(c, 'new').isDraft, isTrue);
    expect(await c.read(jobRepositoryProvider).findJob('new'), isNull);
  });

  test('the first message creates the job and records the turn', () async {
    generator.enqueue(rawResponse([diagnosis], text: 'Easy fix.'));
    final c = container();
    final controller = await open(c, 'j1');

    await controller.send(
      'Faucet drips. Since Monday.',
      photo: PickedPhoto(bytes: Uint8List.fromList([1]), width: 1, height: 1),
    );

    final state = stateOf(c, 'j1');
    expect(state.job!.title, 'Faucet drips');
    expect(state.job!.thumbnailPath, isNotNull);
    expect(state.timeline, hasLength(2));
    expect((state.timeline.last as ModelTimelineItem).text, 'Easy fix.');
    expect(generator.requests.single.input.promptText, contains('Faucet'));
    expect(photos.files, hasLength(1));
    final entries = await c.read(jobRepositoryProvider).entries('j1');
    expect(entries, hasLength(2));
  });

  test('ignores empty sends', () async {
    final c = container();
    final controller = await open(c, 'j1');

    await controller.send('   ');

    expect(generator.requests, isEmpty);
    expect(stateOf(c, 'j1').isDraft, isTrue);
  });

  test('a failed turn can be retried', () async {
    generator
      ..enqueue(const OfflineFailure())
      ..enqueue(rawResponse([diagnosis]));
    final c = container();
    final controller = await open(c, 'j1');

    await controller.send('Faucet drips');
    await pumpEventQueue();
    expect(stateOf(c, 'j1').failure, isA<OfflineFailure>());
    expect(stateOf(c, 'j1').isGenerating, isFalse);

    await controller.retry();
    expect(stateOf(c, 'j1').failure, isNull);
    expect(stateOf(c, 'j1').timeline, hasLength(2));

    generator.enqueue(const RateLimitedFailure());
    await controller.send('again');
    await pumpEventQueue();
    expect(stateOf(c, 'j1').failure, isA<RateLimitedFailure>());
    controller.dismissFailure();
    expect(stateOf(c, 'j1').failure, isNull);
  });

  test('ticking the latest checklist drives the job status', () async {
    generator.enqueue(rawResponse([checklist]));
    final c = container();
    final controller = await open(c, 'j1');
    await controller.send('Tile cracked');
    final surfaceId =
        (stateOf(c, 'j1').timeline.last as ModelTimelineItem).surfaceIds.single;
    expect(stateOf(c, 'j1').job!.status, JobStatus.inProgress);

    await controller.onChecklistChanged(surfaceId, 'checklist', {'a'});
    expect(stateOf(c, 'j1').job!.completedSteps, 1);

    await controller.onChecklistChanged(surfaceId, 'checklist', {'a', 'b'});
    final job = await c.read(jobRepositoryProvider).findJob('j1');
    expect(job!.status, JobStatus.done);
    expect(stateOf(c, 'j1').job!.status, JobStatus.done);
  });

  test('reopening a job restores its timeline and progress', () async {
    generator.enqueue(rawResponse([checklist], text: 'Plan'));
    final first = container();
    final controller = await open(first, 'j1');
    await controller.send('Tile cracked');
    final surfaceId = (stateOf(first, 'j1').timeline.last as ModelTimelineItem)
        .surfaceIds
        .single;
    await controller.onChecklistChanged(surfaceId, 'checklist', {'a'});
    first.dispose();

    final second = container();
    final reopened = await open(second, 'j1');
    final state = stateOf(second, 'j1');

    expect(state.isDraft, isFalse);
    expect(state.timeline.map((i) => i.runtimeType), [
      UserTimelineItem,
      ModelTimelineItem,
    ]);
    expect(state.job!.completedSteps, 1);
    expect(
      reopened.surfaceContext(surfaceId).definition.value,
      isNotNull,
      reason: 'surface replayed into the new session',
    );
  });

  test('storage failures surface as a failure, not a crash', () async {
    final c = container();
    final controller = await open(c, 'j1');
    await db.close();

    await controller.send('Faucet drips');

    expect(stateOf(c, 'j1').failure, isA<StorageFailure>());
  });
}
