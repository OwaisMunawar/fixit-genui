// Fails the build when line coverage of the code that carries the app's
// logic drops below a threshold.
//
// Usage: dart run tool/coverage_gate.dart coverage/lcov.info 85
//
// Only hand-written code under lib/genui and lib/features/*/domain is
// counted. Generated files are excluded; presentation code is covered by
// widget tests but deliberately not gated, so a new screen never blocks a
// release on a percentage.
import 'dart:io';

final _gated = [RegExp('^lib/genui/'), RegExp('^lib/features/[^/]+/domain/')];
final _generated = RegExp(r'\.(g|freezed)\.dart$');

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'coverage/lcov.info';
  final threshold = args.length > 1 ? double.parse(args[1]) : 85;
  final file = File(path);
  if (!file.existsSync()) {
    stderr.writeln('No coverage report at $path. Run flutter test --coverage.');
    exit(2);
  }

  final perFile = <String, (int, int)>{};
  String? current;
  var found = 0;
  var hit = 0;
  for (final line in file.readAsLinesSync()) {
    if (line.startsWith('SF:')) {
      current = line.substring(3).replaceAll(r'\', '/');
      final libIndex = current.indexOf('lib/');
      if (libIndex > 0) current = current.substring(libIndex);
      found = 0;
      hit = 0;
    } else if (line.startsWith('DA:')) {
      found++;
      if (!line.endsWith(',0')) hit++;
    } else if (line == 'end_of_record' && current != null) {
      perFile[current] = (found, hit);
      current = null;
    }
  }

  var totalFound = 0;
  var totalHit = 0;
  final rows = <String>[];
  for (final MapEntry(key: path, value: (f, h)) in perFile.entries) {
    if (_generated.hasMatch(path)) continue;
    if (!_gated.any((pattern) => pattern.hasMatch(path))) continue;
    totalFound += f;
    totalHit += h;
    rows.add(
      '${(f == 0 ? 100 : h * 100 / f).toStringAsFixed(1).padLeft(6)}%  $path',
    );
  }
  rows
    ..sort()
    ..forEach(stdout.writeln);

  final percent = totalFound == 0 ? 0 : totalHit * 100 / totalFound;
  stdout.writeln(
    '\nGated coverage: ${percent.toStringAsFixed(1)}% '
    '($totalHit/$totalFound lines), threshold $threshold%',
  );
  if (percent < threshold) {
    stderr.writeln('Coverage is below the threshold.');
    exit(1);
  }
}
