import 'package:a2ui_core/a2ui_core.dart' as core;
import 'package:fixit/genui/catalog/catalog_names.dart';
import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/catalog/surface_scope.dart';
import 'package:fixit/l10n/gen/app_localizations_en.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:genui/genui.dart';

import '../../helpers/pump_app.dart';
import '../../helpers/responses.dart';

/// Renders raw components straight through genui, skipping the validation
/// pipeline, to test what catalog items do on their own.
SurfaceController controllerWith(List<Map<String, Object?>> components) {
  return SurfaceController(catalogs: [FixitCatalog.catalog])
    ..handleMessage(
      core.CreateSurfaceMessage(
        surfaceId: 's',
        catalogId: FixitCatalog.id,
      ),
    )
    ..handleMessage(
      core.UpdateComponentsMessage(
        surfaceId: 's',
        components: components,
      ),
    );
}

void main() {
  final l10n = AppLocalizationsEn();

  testWidgets('an unparseable payload renders a fallback, not a crash', (
    tester,
  ) async {
    final controller = controllerWith([
      {'id': 'root', 'component': 'DiagnosisCard', 'title': 'No cause'},
    ]);
    addTearDown(controller.dispose);

    await tester.pumpApp(Surface(surfaceContext: controller.contextFor('s')));

    expect(find.text(l10n.fallbackTitle), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('checklist ticks land in the data model and the host scope', (
    tester,
  ) async {
    final controller = controllerWith([
      stackOf(['checklist']),
      checklist,
    ]);
    addTearDown(controller.dispose);
    final reported = <Set<String>>[];

    await tester.pumpApp(
      FixitSurfaceScope(
        onChecklistChanged: (surfaceId, componentId, completed) {
          expect((surfaceId, componentId), ('s', 'checklist'));
          reported.add(completed);
        },
        child: Surface(surfaceContext: controller.contextFor('s')),
      ),
    );

    await tester.tap(find.text('1. First'));
    await tester.pump();
    await tester.tap(find.text('2. Second'));
    await tester.pump();
    await tester.tap(find.text('1. First'));
    await tester.pump();

    expect(reported, [
      {'a'},
      {'a', 'b'},
      {'b'},
    ]);
    expect(
      controller
          .contextFor('s')
          .dataModel
          .getValue<List<Object?>>(
            DataPath(FixitDataPaths.checklist('checklist')),
          ),
      ['b'],
    );
    expect(find.text('1/2'), findsOneWidget);
  });

  testWidgets('a checklist without a host scope still works', (tester) async {
    final controller = controllerWith([
      {...checklist, 'id': 'root'},
    ]);
    addTearDown(controller.dispose);

    await tester.pumpApp(Surface(surfaceContext: controller.contextFor('s')));
    await tester.tap(find.byType(Checkbox).first);
    await tester.pump();

    expect(find.text('1/2'), findsOneWidget);
  });

  testWidgets('the response stack lays children out in order', (
    tester,
  ) async {
    final controller = controllerWith([
      stackOf(['second', 'first']),
      {'id': 'first', 'component': 'NoteCard', 'body': 'First note'},
      {'id': 'second', 'component': 'NoteCard', 'body': 'Second note'},
    ]);
    addTearDown(controller.dispose);

    await tester.pumpApp(Surface(surfaceContext: controller.contextFor('s')));

    final first = tester.getTopLeft(find.text('First note'));
    final second = tester.getTopLeft(find.text('Second note'));
    expect(second.dy, lessThan(first.dy));
  });

  testWidgets('the scope only notifies when its callback changes', (
    tester,
  ) async {
    void callback(String a, String b, Set<String> c) {}
    final scope = FixitSurfaceScope(
      onChecklistChanged: callback,
      child: const SizedBox(),
    );
    expect(
      scope.updateShouldNotify(
        FixitSurfaceScope(
          onChecklistChanged: callback,
          child: const SizedBox(),
        ),
      ),
      isFalse,
    );
  });
}
