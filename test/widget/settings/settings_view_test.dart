import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_controller.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../unit/settings/fake_settings_service.dart';

void main() {
  group('Settings view tests', () {
    testWidgets('Only default selection is visible', (tester) async {
      var controller = SettingsController(FakeSettingsService(ThemeMode.light));
      await controller.init();
      await tester.pumpWidget(
        MaterialApp(
          home: SettingsView(controller: controller),
        ),
      );

      expect(find.text('System'), findsNothing);
      expect(find.text('Light'), findsOne);
    });

    testWidgets('Switches selection triggered by controller', (tester) async {
      var controller =
          SettingsController(FakeSettingsService(ThemeMode.system));
      await controller.init();
      await tester.pumpWidget(
        ListenableBuilder(
            listenable: controller,
            builder: (context, _) {
              return MaterialApp(
                home: SettingsView(controller: controller),
              );
            }),
      );

      await controller.updateThemeMode(ThemeMode.light);
      await tester.pumpAndSettle();

      expect(find.text('System'), findsNothing);
      expect(find.text('Light'), findsOne);
    });
  });
}
