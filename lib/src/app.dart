import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_controller.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_view.dart';

class MyApp extends StatelessWidget {
  final SettingsController controller;

  const MyApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: controller.themeMode,
          onGenerateRoute: (settings) => MaterialPageRoute(
              settings: settings,
              builder: (_) => switch (settings.name) {
                    // SettingsView.routeName =>
                    //   SettingsView(controller: controller),
                    _ => SettingsView(controller: controller),
                    // _ => const Placeholder(),
                  }),
        );
      },
    );
  }
}
