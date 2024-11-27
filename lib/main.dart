import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_controller.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_service.dart';

import 'src/app.dart';

void main() async {
  var settings = SettingsController(SettingsService());

  await settings.init();

  runApp(MyApp(controller: settings,));
}
