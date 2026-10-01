import 'package:flutter/foundation.dart';

/// A downscaled photo ready to send, plus where it lives on disk.
@immutable
final class ImageAttachment {
  const ImageAttachment({
    required this.bytes,
    this.mimeType = 'image/jpeg',
    this.path,
  });

  final Uint8List bytes;
  final String mimeType;

  /// Set once the image has been written to the job's folder.
  final String? path;
}

/// What the user just did that needs a response.
sealed class TurnInput {
  const TurnInput();

  /// The input as plain text for a model that only sees conversation turns.
  String get promptText;
}

final class TextInput extends TurnInput {
  const TextInput({required this.text, this.image});

  final String text;
  final ImageAttachment? image;

  @override
  String get promptText => text;
}

/// Answers submitted from a generated QuestionForm.
final class AnswersInput extends TurnInput {
  const AnswersInput({
    required this.surfaceId,
    required this.componentId,
    required this.formTitle,
    required this.answers,
    required this.summary,
  });

  final String surfaceId;
  final String componentId;
  final String formTitle;
  final Map<String, Object?> answers;

  /// "Question Answer" lines, written by the form for the model to read.
  final List<String> summary;

  @override
  String get promptText {
    final lines = summary.map((line) => '- $line').join('\n');
    return 'My answers to "$formTitle":\n$lines';
  }
}

enum RepairRole { user, model }

/// One past turn in the job, in the shape a generator needs to rebuild
/// context for a stateless API.
@immutable
final class RepairTurn {
  const RepairTurn({required this.role, required this.text, this.image});

  factory RepairTurn.fromInput(TurnInput input) => RepairTurn(
    role: RepairRole.user,
    text: input.promptText,
    image: switch (input) {
      TextInput(:final image) => image,
      AnswersInput() => null,
    },
  );

  final RepairRole role;
  final String text;
  final ImageAttachment? image;
}

@immutable
final class RepairRequest {
  const RepairRequest({required this.history, required this.input});

  final List<RepairTurn> history;
  final TurnInput input;

  int get completedModelTurns =>
      history.where((turn) => turn.role == RepairRole.model).length;
}
