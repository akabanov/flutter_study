import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Settings service retrieves and stores theme', () {
    test('Settings service retrieves system theme', () async {
      expect(await SettingsService().themeMode(), ThemeMode.system);
    });
  });
}
