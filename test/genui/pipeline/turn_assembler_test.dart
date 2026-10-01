import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/genui/pipeline/pipeline_issue.dart';
import 'package:fixit/genui/pipeline/response_parser.dart';
import 'package:fixit/genui/pipeline/turn_assembler.dart';
import 'package:flutter_test/flutter_test.dart';

ParsedResponse parsed(List<core.A2uiMessage> messages) =>
    ParsedResponse(messages: messages, text: '', issues: const []);

core.UpdateComponentsMessage update(
  String surfaceId,
  List<Map<String, dynamic>> components,
) => core.UpdateComponentsMessage(
  surfaceId: surfaceId,
  components: components,
);

void main() {
  const assembler = TurnAssembler();

  test('renames model surface ids to turn-scoped ids', () {
    final turn = assembler.assemble(
      parsed([
        core.CreateSurfaceMessage(
          surfaceId: 'main',
          catalogId: 'x',
        ),
        update('main', [
          {'id': 'root', 'component': 'NoteCard', 'body': 'Hi'},
        ]),
      ]),
      surfacePrefix: 't3',
    );

    expect(turn.surfaces.single.surfaceId, 't3-0');
  });

  test('creates a surface when the model skips createSurface', () {
    final turn = assembler.assemble(
      parsed([
        update('a', [
          {'id': 'root', 'component': 'NoteCard', 'body': 'Hi'},
        ]),
      ]),
      surfacePrefix: 't0',
    );

    expect(turn.surfaces, hasLength(1));
  });

  test('later component definitions replace earlier ones in place', () {
    final turn = assembler.assemble(
      parsed([
        update('a', [
          {'id': 'root', 'component': 'NoteCard', 'body': 'old'},
          {'id': 'other', 'component': 'NoteCard', 'body': 'x'},
        ]),
        update('a', [
          {'id': 'root', 'component': 'NoteCard', 'body': 'new'},
        ]),
      ]),
      surfacePrefix: 't0',
    );

    final components = turn.surfaces.single.components;
    expect(components.first['body'], 'new');
    expect(components, hasLength(2));
  });

  test('assigns ids to anonymous components', () {
    final turn = assembler.assemble(
      parsed([
        update('a', [
          {'component': 'NoteCard', 'body': 'no id'},
        ]),
      ]),
      surfacePrefix: 't0',
    );

    expect(turn.surfaces.single.components.single['id'], 'auto_0');
    expect(turn.issues.single.kind, IssueKind.missingId);
  });

  test('drops deletes, orphan updates and writes to app-owned paths', () {
    final turn = assembler.assemble(
      parsed([
        update('a', [
          {'id': 'root', 'component': 'NoteCard', 'body': 'x'},
        ]),
        core.UpdateDataModelMessage(
          surfaceId: 'a',
          path: '/fixit/checklists/c',
          value: ['a'],
        ),
        core.UpdateDataModelMessage(
          surfaceId: 'a',
          path: '/note',
          value: 1,
        ),
        core.UpdateDataModelMessage(
          surfaceId: 'elsewhere',
          path: '/x',
          value: 1,
        ),
        core.DeleteSurfaceMessage(surfaceId: 'old'),
      ]),
      surfacePrefix: 't0',
    );

    expect(turn.surfaces.single.dataUpdates.single.path, '/note');
    expect(
      turn.issues.map((i) => i.kind),
      containsAll([
        IssueKind.reservedPath,
        IssueKind.orphanUpdate,
        IssueKind.disallowedOperation,
      ]),
    );
  });

  test('skips surfaces that never received components', () {
    final turn = assembler.assemble(
      parsed([
        core.CreateSurfaceMessage(
          surfaceId: 'empty',
          catalogId: 'x',
        ),
      ]),
      surfacePrefix: 't0',
    );

    expect(turn.surfaces, isEmpty);
    expect(turn.issues.single.kind, IssueKind.emptySurface);
  });
}
