import 'dart:async';
import 'dart:io';

import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/core/ui/adaptive.dart';
import 'package:fixit/core/ui/mode_badge.dart';
import 'package:fixit/features/assistant/presentation/job_session_controller.dart';
import 'package:fixit/features/assistant/presentation/job_session_state.dart';
import 'package:fixit/features/assistant/presentation/widgets/assistant_note.dart';
import 'package:fixit/features/assistant/presentation/widgets/composer.dart';
import 'package:fixit/features/assistant/presentation/widgets/failure_banner.dart';
import 'package:fixit/features/assistant/presentation/widgets/new_job_intro.dart';
import 'package:fixit/features/assistant/presentation/widgets/thinking_indicator.dart';
import 'package:fixit/features/assistant/presentation/widgets/user_bubble.dart';
import 'package:fixit/features/jobs/jobs_providers.dart';
import 'package:fixit/genui/catalog/surface_scope.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:genui/genui.dart';

/// One job: the timeline of what the user said and the UI the model
/// answered with, plus the composer.
class JobScreen extends ConsumerWidget {
  const JobScreen({required this.jobId, this.embedded = false, super.key});

  final String jobId;

  /// True in the tablet detail pane, where the jobs list owns the app bar's
  /// mode badge and there is no back button.
  final bool embedded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final provider = jobSessionControllerProvider(jobId);
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    final title = state.job?.title;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !embedded,
        title: Text(
          title == null
              ? l10n.newJobTitle
              : title.isEmpty
              ? l10n.untitledJob
              : title,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [if (!embedded) const ModeBadge()],
      ),
      body: Column(
        children: [
          Expanded(
            child: switch (state) {
              JobSessionState(isLoading: true) => const Center(
                child: CircularProgressIndicator(),
              ),
              JobSessionState(timeline: []) => NewJobIntro(
                onSample: (sample) => unawaited(controller.send(sample.prompt)),
              ),
              _ => FixitSurfaceScope(
                onChecklistChanged: (surfaceId, componentId, completed) =>
                    unawaited(
                      controller.onChecklistChanged(
                        surfaceId,
                        componentId,
                        completed,
                      ),
                    ),
                child: _Timeline(
                  state: state,
                  surfaceContext: controller.surfaceContext,
                ),
              ),
            },
          ),
          if (state.failure case final failure?)
            FailureBanner(
              failure: failure,
              onRetry: () => unawaited(controller.retry()),
              onDismiss: controller.dismissFailure,
            ),
          Composer(
            enabled: !state.isGenerating && !state.isLoading,
            onSubmit: (text, photo) => controller.send(text, photo: photo),
          ),
        ],
      ),
    );
  }
}

class _Timeline extends ConsumerStatefulWidget {
  const _Timeline({required this.state, required this.surfaceContext});

  final JobSessionState state;
  final SurfaceContext Function(String surfaceId) surfaceContext;

  @override
  ConsumerState<_Timeline> createState() => _TimelineState();
}

class _TimelineState extends ConsumerState<_Timeline> {
  final _scroll = ScrollController();
  final GlobalKey _latestKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollToEnd(animate: false);
  }

  @override
  void didUpdateWidget(_Timeline oldWidget) {
    super.didUpdateWidget(oldWidget);
    final before = oldWidget.state.timeline.length;
    final after = widget.state.timeline.length;
    if (after > before) {
      // A new answer is scrolled to its top, not the bottom: the diagnosis
      // or banner is what the user needs to read first.
      widget.state.timeline.last is ModelTimelineItem
          ? _revealLatest()
          : _scrollToEnd();
    } else if (widget.state.isGenerating && !oldWidget.state.isGenerating) {
      _scrollToEnd();
    }
  }

  void _scrollToEnd({bool animate = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      final end = _scroll.position.maxScrollExtent;
      animate
          ? unawaited(
              _scroll.animateTo(
                end,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOut,
              ),
            )
          : _scroll.jumpTo(end);
    });
  }

  void _revealLatest() {
    // Surfaces render a frame after their timeline item, so wait two frames
    // for the answer to have its real height.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = _latestKey.currentContext;
        if (context == null || !context.mounted) {
          // Not built yet because it is still outside the cache extent.
          _scrollToEnd();
          return;
        }
        unawaited(
          Scrollable.ensureVisible(
            context,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.state.timeline;
    final photos = ref.watch(photoStoreProvider);
    return ListView.builder(
      controller: _scroll,
      padding: const EdgeInsets.fromLTRB(
        Insets.lg,
        Insets.lg,
        Insets.lg,
        Insets.xl,
      ),
      itemCount: items.length + (widget.state.isGenerating ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == items.length) {
          return const ContentWidth(child: ThinkingIndicator());
        }
        final item = items[index];
        final child = switch (item) {
          UserTimelineItem(:final text, :final imagePath) => UserBubble(
            text: text,
            imageFile: imagePath == null
                ? null
                : File(photos.absolutePath(imagePath)),
          ),
          ModelTimelineItem(:final text, :final surfaceIds) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (text.isNotEmpty) ...[
                AssistantNote(text),
                const SizedBox(height: Insets.md),
              ],
              for (final surfaceId in surfaceIds)
                Surface(
                  key: ValueKey(surfaceId),
                  surfaceContext: widget.surfaceContext(surfaceId),
                ),
            ],
          ),
        };
        return Padding(
          key: index == items.length - 1 ? _latestKey : null,
          padding: const EdgeInsets.only(bottom: Insets.lg),
          child: ContentWidth(child: child),
        );
      },
    );
  }
}
