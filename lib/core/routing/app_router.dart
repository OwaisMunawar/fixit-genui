import 'package:fixit/features/assistant/presentation/job_screen.dart';
import 'package:fixit/features/jobs/presentation/jobs_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRoutes {
  static const jobs = '/';

  static String job(String id) => '/jobs/$id';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.jobs,
        builder: (context, state) => const JobsScreen(),
        routes: [
          GoRoute(
            path: 'jobs/:id',
            builder: (context, state) =>
                JobScreen(jobId: state.pathParameters['id']!),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
