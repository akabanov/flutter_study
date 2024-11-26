import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_service.dart';

class SettingsController with ChangeNotifier {
  final SettingsService _service;
  late ThemeMode _themeMode;

  SettingsController(this._service);

  Future<void> init() async {
    _themeMode = await _service.themeMode();
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    if (_themeMode == themeMode) {
      return;
    }

    _themeMode = themeMode;

    notifyListeners();

    await _service.updateThemeMode(themeMode);
  }
}
