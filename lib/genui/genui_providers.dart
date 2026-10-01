import 'package:fixit/core/config/app_config.dart';
import 'package:fixit/core/di/core_providers.dart';
import 'package:fixit/genui/catalog/fixit_catalog.dart';
import 'package:fixit/genui/generator/demo/demo_repair_generator.dart';
import 'package:fixit/genui/generator/gemini/gemini_repair_generator.dart';
import 'package:fixit/genui/generator/repair_generator.dart';
import 'package:fixit/genui/generator/system_prompt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repairGeneratorProvider = Provider<RepairGenerator>((ref) {
  final config = ref.watch(appConfigProvider);
  return switch (config.mode) {
    GeneratorMode.demo => const DemoRepairGenerator(),
    GeneratorMode.gemini => GeminiRepairGenerator(
      dio: GeminiRepairGenerator.createDio(),
      apiKey: config.geminiApiKey,
      model: config.geminiModel,
      systemPrompt: FixitSystemPrompt.build(FixitCatalog.catalog),
    ),
  };
});
