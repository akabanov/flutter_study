import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_controller.dart';
import 'package:flutter_study_skeleton_app/src/settings/settings_view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../unit/settings/fake_settings_service.dart';

void main() {
  group('Settings view tests', () {
    late SettingsController controller;
    late Widget appWidget;

    setUp(() async {
      controller = SettingsController(FakeSettingsService(ThemeMode.light));
      await controller.init();

      appWidget = ListenableBuilder(
          listenable: controller,
          builder: (context, _) => MaterialApp(
                home: SettingsView(controller: controller),
              ));
    });

    testWidgets('Correct theme mode segment is selected', (tester) async {
      await tester.pumpWidget(appWidget);

      // Initial state check
      expect(themeButton(tester).selected, {ThemeMode.light});

      // Perform the tap
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      expect(themeButton(tester).selected, {ThemeMode.dark});
    });
  });
}

SegmentedButton<ThemeMode> themeButton(WidgetTester tester) {
  return tester.widget<SegmentedButton<ThemeMode>>(
        find.byType(SegmentedButton<ThemeMode>));
}
