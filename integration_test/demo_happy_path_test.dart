import 'package:drift/native.dart';
import 'package:fixit/bootstrap.dart';
import 'package:fixit/core/config/app_config.dart';
import 'package:fixit/core/di/core_providers.dart';
import 'package:fixit/features/jobs/data/database/app_database.dart';
import 'package:fixit/features/jobs/jobs_providers.dart';
import 'package:fixit/genui/generator/demo/demo_repair_generator.dart';
import 'package:fixit/genui/genui_providers.dart';
import 'package:fixit/l10n/gen/app_localizations_en.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// The whole demo on a real device or simulator: start a job from a sample,
/// answer the generated form, work through the generated checklist, and see
/// the job marked done in the list.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final l10n = AppLocalizationsEn();

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  testWidgets('leaky faucet, start to finish, in demo mode', (tester) async {
    final db = AppDatabase(NativeDatabase.memory());
    addTearDown(db.close);

    await tester.pumpWidget(
      await bootstrap(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(
              geminiApiKey: '',
              geminiModel: 'unused',
              forceDemo: true,
            ),
          ),
          appDatabaseProvider.overrideWithValue(db),
          repairGeneratorProvider.overrideWithValue(
            const DemoRepairGenerator(latency: Duration(milliseconds: 300)),
          ),
        ],
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(l10n.emptyJobsTitle), findsOneWidget);
    await tap(tester, find.text(l10n.newJob));
    await tap(tester, find.text(l10n.sampleLeakyFaucet));

    expect(find.text('Dripping kitchen faucet'), findsOneWidget);
    await tap(tester, find.text('Two handles'));
    await tap(tester, find.text('The spout'));
    await tap(tester, find.text(l10n.yes).last);
    await tap(tester, find.text('Get my fix plan'));

    expect(find.text('Replace the washers and seats'), findsOneWidget);
    const steps = [
      '1. Turn off the water',
      '2. Plug the drain',
      '3. Remove both handles',
      '4. Unscrew the valve stems',
      '5. Swap the washers and O-rings',
      '6. Check the valve seats',
      '7. Restore water and test',
    ];
    for (final step in steps) {
      await tap(tester, find.text(step));
    }
    expect(find.text('7/7'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text(l10n.statusDone), findsOneWidget);
  });
}
