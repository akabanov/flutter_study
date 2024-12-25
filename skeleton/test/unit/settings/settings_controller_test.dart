import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_controller.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_settings_service.dart';

void main() {
  group('Settings controller tests', () {
    test('Initializer sends notification', () async {
      var counter = 0;
      var settingsController = SettingsController(FakeSettingsService());
      settingsController.addListener(() => counter++);
      await settingsController.init();

      expect(counter, 1);
    });

    test('Initializer reads theme', () async {
      const ThemeMode themeMode = ThemeMode.dark;
      var settingsController =
          SettingsController(FakeSettingsService(themeMode));
      await settingsController.init();

      expect(settingsController.themeMode, themeMode);
    });

    test('Updates theme mode', () async {
      var service = FakeSettingsService(ThemeMode.light);
      var controller = SettingsController(service);
      await controller.init();
      await controller.updateThemeMode(ThemeMode.dark);

      expect(await service.themeMode(), ThemeMode.dark);
    });

    test('Sends notifications after theme mode is updated', () async {
      ThemeMode mode = ThemeMode.light;
      var controller = SettingsController(FakeSettingsService(mode));
      controller.addListener(() => mode = controller.themeMode);
      await controller.init();
      await controller.updateThemeMode(ThemeMode.dark);

      expect(mode, ThemeMode.dark);
    });
  });
}
