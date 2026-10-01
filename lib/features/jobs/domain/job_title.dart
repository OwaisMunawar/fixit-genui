/// Derives a short job title from the first thing the user typed.
abstract final class JobTitle {
  static const maxLength = 48;

  static String fromPrompt(String prompt, {required String fallback}) {
    final firstLine = prompt.trim().split('\n').first.trim();
    if (firstLine.isEmpty) return fallback;
    final sentence = firstLine.split(RegExp(r'(?<=[.!?])\s')).first;
    final text = sentence.replaceAll(RegExp(r'[.!?]+$'), '');
    if (text.length <= maxLength) return text;
    final cut = text.substring(0, maxLength);
    final lastSpace = cut.lastIndexOf(' ');
    return '${(lastSpace > 20 ? cut.substring(0, lastSpace) : cut).trim()}…';
  }
}
