import 'package:fixit/app.dart';
import 'package:fixit/features/jobs/domain/job.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:fixit/genui/generator/demo/demo_repair_generator.dart';
import 'package:fixit/l10n/gen/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_overrides.dart';
import '../helpers/fakes.dart';

/// genui's stream parser only makes progress on the real event loop, and
/// the thinking spinner never settles, so this alternates short real waits
/// with fixed frame pumps instead of using `pumpAndSettle`.
Future<void> settle(WidgetTester tester, {int frames = 8}) async {
  for (var i = 0; i < frames; i++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 2)),
    );
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pump(const Duration(milliseconds: 300));
  await tester.tap(finder);
  await settle(tester);
}

Job seededJob(String id, String title, JobStatus status) => Job(
  id: id,
  title: title,
  status: status,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

void main() {
  final l10n = AppLocalizationsEn();
  late InMemoryJobRepository repository;
  late MemoryPhotoStore photos;

  setUp(() {
    repository = InMemoryJobRepository();
    photos = MemoryPhotoStore();
  });

  Future<void> pumpFixit(WidgetTester tester, {Size? size}) async {
    if (size != null) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
    }
    await tester.pumpWidget(
      ProviderScope(
        overrides: appOverrides(
          repository: repository,
          generator: const DemoRepairGenerator(latency: Duration.zero),
          photos: photos,
        ),
        child: const FixitApp(),
      ),
    );
    await settle(tester);
  }

  testWidgets('a demo job runs from sample to finished checklist', (
    tester,
  ) async {
    await pumpFixit(tester);
    expect(find.text(l10n.emptyJobsTitle), findsOneWidget);
    expect(find.text(l10n.demoModeBadge), findsOneWidget);

    await tapAndSettle(tester, find.text(l10n.newJob));
    await tapAndSettle(tester, find.text(l10n.sampleLeakyFaucet));

    expect(find.text('Dripping kitchen faucet'), findsOneWidget);
    expect(find.text('A few quick questions'), findsOneWidget);

    await tapAndSettle(tester, find.text('One lever'));
    await tapAndSettle(tester, find.text('The spout'));
    await tapAndSettle(tester, find.text(l10n.yes).last);
    await tapAndSettle(tester, find.text('Get my fix plan'));

    expect(find.text('Replace the cartridge'), findsOneWidget);

    for (final step in [
      '1. Turn off the water',
      '2. Plug the drain',
      '3. Remove the handle',
      '4. Pull the old cartridge',
      '5. Fit the new cartridge',
      '6. Restore water and test',
    ]) {
      await tapAndSettle(tester, find.text(step));
    }
    expect(find.text('6/6'), findsOneWidget);
    expect(find.text('Replacement cartridge'), findsOneWidget);

    final job = (await repository.watchJobs().first).single;
    expect(job.status, JobStatus.done);
    expect(job.title, 'My kitchen faucet keeps dripping even when the…');

    await tester.pageBack();
    await settle(tester);
    expect(find.text(l10n.statusDone), findsOneWidget);
    expect(find.textContaining('6/6 steps'), findsOneWidget);
  });

  testWidgets('the breaker demo shows guardrail-added safety content', (
    tester,
  ) async {
    await pumpFixit(tester);
    await tapAndSettle(tester, find.text(l10n.newJob));
    await tapAndSettle(tester, find.text(l10n.sampleTrippedBreaker));

    expect(find.text('Only touch the breaker handle'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text(l10n.addedBySafetyCheck),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text(l10n.addedBySafetyCheck), findsOneWidget);
  });

  testWidgets('typing a message works without a sample', (tester) async {
    await pumpFixit(tester);
    await tapAndSettle(tester, find.text(l10n.newJob));

    await tester.enterText(find.byType(TextField), 'The grout is cracking');
    await tester.pump();
    await tapAndSettle(tester, find.byTooltip(l10n.send));

    expect(find.text('The grout is cracking'), findsWidgets);
    expect(find.text('Cracked floor tile'), findsOneWidget);
  });

  testWidgets('tablets show the list and the open job side by side', (
    tester,
  ) async {
    await repository.createJob(
      seededJob('existing', 'Squeaky hinge', JobStatus.diagnosing),
    );

    await pumpFixit(tester, size: const Size(1280, 900));
    expect(find.text(l10n.selectJobHint), findsOneWidget);

    await tapAndSettle(tester, find.text('Squeaky hinge'));
    expect(find.text(l10n.selectJobHint), findsNothing);
    expect(find.text(l10n.samplesTitle.toUpperCase()), findsOneWidget);

    await tapAndSettle(tester, find.byType(FloatingActionButton));
    expect(find.text(l10n.samplesTitle.toUpperCase()), findsOneWidget);
  });

  testWidgets('swiping a job away deletes it after confirmation', (
    tester,
  ) async {
    await repository.createJob(seededJob('doomed', 'Old job', JobStatus.done));
    await pumpFixit(tester);

    await tester.drag(find.text('Old job'), const Offset(-600, 0));
    await settle(tester);
    await tester.tap(find.text(l10n.cancel));
    await settle(tester);
    expect(find.text('Old job'), findsOneWidget);

    await tester.drag(find.text('Old job'), const Offset(-600, 0));
    await settle(tester);
    await tester.tap(find.text(l10n.delete));
    await settle(tester);

    expect(find.text('Old job'), findsNothing);
    expect(find.text(l10n.emptyJobsTitle), findsOneWidget);
    expect(photos.deletedJobs, ['doomed']);
  });
}
