import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_service.dart';

class FakeSettingsService implements SettingsService {
  ThemeMode _themeMode;

  FakeSettingsService([this._themeMode = ThemeMode.system]);

  @override
  Future<ThemeMode> themeMode() async {
    return _themeMode;
  }

  @override
  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
  }
}
