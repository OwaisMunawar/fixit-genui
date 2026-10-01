import 'package:fixit/features/jobs/domain/checklist_ref.dart';
import 'package:fixit/features/jobs/domain/job_entry.dart';
import 'package:fixit/features/jobs/domain/job_progress.dart';
import 'package:fixit/features/jobs/domain/job_status.dart';
import 'package:fixit/features/jobs/domain/job_title.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JobProgress.derive', () {
    const first = ChecklistRef(
      surfaceId: 't1-0',
      componentId: 'checklist',
      stepIds: ['a', 'b'],
    );
    const second = ChecklistRef(
      surfaceId: 't2-0',
      componentId: 'checklist',
      stepIds: ['x', 'y', 'z'],
    );

    test('no checklist yet means diagnosing', () {
      expect(
        JobProgress.derive(checklists: const [], completed: const {}),
        JobProgress.diagnosing,
      );
    });

    test('a partly ticked checklist is in progress', () {
      final progress = JobProgress.derive(
        checklists: const [first],
        completed: {
          first.key: const {'a'},
        },
      );
      expect(progress.status, JobStatus.inProgress);
      expect((progress.completedSteps, progress.totalSteps), (1, 2));
    });

    test('the latest checklist decides, and ignores unknown ids', () {
      final progress = JobProgress.derive(
        checklists: const [first, second],
        completed: {
          first.key: const {'a', 'b'},
          second.key: const {'x', 'y', 'z', 'stale'},
        },
      );
      expect(progress.status, JobStatus.done);
      expect(progress.completedSteps, 3);
    });

    test('equality is by value', () {
      const a = JobProgress(
        status: JobStatus.done,
        completedSteps: 1,
        totalSteps: 1,
      );
      expect(
        a,
        const JobProgress(
          status: JobStatus.done,
          completedSteps: 1,
          totalSteps: 1,
        ),
      );
      expect(a.hashCode, isNot(JobProgress.diagnosing.hashCode));
    });
  });

  group('JobTitle.fromPrompt', () {
    test('takes the first sentence without its full stop', () {
      expect(
        JobTitle.fromPrompt('Faucet drips. It started today.', fallback: ''),
        'Faucet drips',
      );
    });

    test('cuts long prompts at a word boundary', () {
      final title = JobTitle.fromPrompt(
        'The kitchen breaker keeps tripping whenever the microwave and kettle '
        'run at the same time',
        fallback: '',
      );
      expect(title.length, lessThanOrEqualTo(JobTitle.maxLength + 1));
      expect(title, endsWith('…'));
      expect(title, isNot(contains('  ')));
    });

    test('falls back for photo-only jobs', () {
      expect(JobTitle.fromPrompt('  ', fallback: 'Photo job'), 'Photo job');
    });
  });

  test('entries survive a JSON round trip', () {
    final entries = [
      JobEntry.user(text: 'Leak', imagePath: 'a.jpg', createdAt: DateTime(1)),
      JobEntry.answers(
        surfaceId: 's',
        componentId: 'q',
        formTitle: 'Q',
        answers: const {
          'n': 1,
          'l': ['a'],
        },
        summary: const ['n 1'],
        createdAt: DateTime(2),
      ),
      JobEntry.model(
        rawResponse: 'raw',
        text: 'text',
        surfaceIds: const ['s'],
        messages: const [
          {'version': 'v0.9'},
        ],
        checklists: const [
          ChecklistRef(surfaceId: 's', componentId: 'c', stepIds: ['a']),
        ],
        categories: const ['electrical'],
        createdAt: DateTime(3),
      ),
    ];
    for (final entry in entries) {
      expect(JobEntry.fromJson(entry.toJson()), entry);
    }
  });
}
