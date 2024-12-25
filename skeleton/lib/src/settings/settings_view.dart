import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme mode:',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            SegmentedButton<ThemeMode>(
              selected: {controller.themeMode},
              onSelectionChanged: (value) =>
                  controller.updateThemeMode(value.first),
              segments: const [
                ButtonSegment(
                    value: ThemeMode.system,
                    label: Text("System"),
                    icon: Icon(Icons.phone_android)),
                ButtonSegment(
                    value: ThemeMode.light,
                    label: Text("Light"),
                    icon: Icon(Icons.light_mode)),
                ButtonSegment(
                    value: ThemeMode.dark,
                    label: Text("Dark"),
                    icon: Icon(Icons.dark_mode)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
