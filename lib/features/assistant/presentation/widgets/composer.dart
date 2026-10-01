import 'dart:async';

import 'package:fixit/core/errors/app_failure.dart';
import 'package:fixit/core/errors/failure_messages.dart';
import 'package:fixit/core/theme/insets.dart';
import 'package:fixit/features/assistant/assistant_providers.dart';
import 'package:fixit/features/assistant/domain/picked_photo.dart';
import 'package:fixit/l10n/gen/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef ComposerSubmit = Future<void> Function(String text, PickedPhoto? photo);

/// Text plus an optional photo.
///
/// It clears as soon as it sends: the message is saved to the timeline before
/// the model is called, and a failed answer is retried from there, so nothing
/// the user typed is lost.
class Composer extends ConsumerStatefulWidget {
  const Composer({required this.enabled, required this.onSubmit, super.key});

  final bool enabled;
  final ComposerSubmit onSubmit;

  @override
  ConsumerState<Composer> createState() => _ComposerState();
}

class _ComposerState extends ConsumerState<Composer> {
  final _controller = TextEditingController();
  PickedPhoto? _photo;
  var _picking = false;

  bool get _canSend =>
      widget.enabled &&
      !_picking &&
      (_controller.text.trim().isNotEmpty || _photo != null);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pick() async {
    final source = ref.read(photoSourceProvider);
    final l10n = AppLocalizations.of(context);
    final origin = source.canUseCamera
        ? await showModalBottomSheet<PhotoOrigin>(
            context: context,
            showDragHandle: true,
            builder: (context) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.photo_camera_outlined),
                    title: Text(l10n.takePhoto),
                    onTap: () => Navigator.pop(context, PhotoOrigin.camera),
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library_outlined),
                    title: Text(l10n.chooseFromLibrary),
                    onTap: () => Navigator.pop(context, PhotoOrigin.library),
                  ),
                ],
              ),
            ),
          )
        : PhotoOrigin.library;
    if (origin == null || !mounted) return;

    setState(() => _picking = true);
    try {
      final photo = await source.pick(origin);
      if (mounted && photo != null) setState(() => _photo = photo);
    } on AppFailure catch (failure) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.localizedMessage(l10n))),
        );
      }
    } finally {
      if (mounted) setState(() => _picking = false);
    }
  }

  Future<void> _send() async {
    if (!_canSend) return;
    final text = _controller.text;
    final photo = _photo;
    _controller.clear();
    setState(() => _photo = null);
    await widget.onSubmit(text, photo);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.surfaceContainerLow,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: Insets.sm),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Insets.sm,
            Insets.sm,
            Insets.sm,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_photo != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: Insets.sm,
                    bottom: Insets.sm,
                  ),
                  child: _PhotoPreview(
                    photo: _photo!,
                    onRemove: () => setState(() => _photo = null),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: widget.enabled && !_picking ? _pick : null,
                    tooltip: l10n.attachPhoto,
                    icon: _picking
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.add_a_photo_outlined),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: widget.enabled,
                      minLines: 1,
                      maxLines: 5,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => unawaited(_send()),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(hintText: l10n.composerHint),
                    ),
                  ),
                  const SizedBox(width: Insets.xs),
                  IconButton.filled(
                    onPressed: _canSend ? () => unawaited(_send()) : null,
                    tooltip: l10n.send,
                    icon: const Icon(Icons.arrow_upward_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoPreview extends StatelessWidget {
  const _PhotoPreview({required this.photo, required this.onRemove});

  final PickedPhoto photo;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Radii.md),
          child: Image.memory(
            photo.bytes,
            height: 72,
            width: 72,
            fit: BoxFit.cover,
            semanticLabel: l10n.photoAttachedSemantics,
          ),
        ),
        Positioned(
          top: -Insets.sm,
          right: -Insets.sm,
          child: IconButton.filledTonal(
            visualDensity: VisualDensity.compact,
            iconSize: 16,
            tooltip: l10n.removePhoto,
            onPressed: onRemove,
            icon: const Icon(Icons.close_rounded),
          ),
        ),
      ],
    );
  }
}
