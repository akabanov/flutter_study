import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gor/route/on_exit.dart';

void main() {
  group('On Exit study tests', () {
    testWidgets('Full path', (t) async {
      var goHomeBtn = find.text('Go home');
      var goDetailsBtn = find.text('Go details');
      var goSettingsBtn = find.text('Go settings');

      var noBtn = find.byKey(const Key('no'));
      var yesBtn = find.byKey(const Key('yes'));

      var homeScreen = find.byKey(const Key('home-screen'));
      var detailsScreen = find.byKey(const Key('details-screen'));
      var settingsScreen = find.byKey(const Key('settings-screen'));

      // test init
      await t.pumpWidget(OEApp());
      expect(homeScreen, findsOne);
      expect(goHomeBtn, findsNothing);
      expect(goDetailsBtn, findsOne);
      expect(goSettingsBtn, findsNothing);

      // home -> details
      await t.tap(goDetailsBtn);
      await t.pumpAndSettle();
      expect(homeScreen, findsNothing);
      expect(detailsScreen, findsOne);
      expect(goHomeBtn, findsOne);
      expect(goDetailsBtn, findsNothing);
      expect(goSettingsBtn, findsOne);

      // preserves state
      await t.restartAndRestore();
      await t.pumpAndSettle();
      expect(detailsScreen, findsOne);

      // shows dialog
      await t.tap(goHomeBtn);
      await t.pumpAndSettle();
      expect(detailsScreen, findsOne);
      expect(noBtn, findsOne);
      expect(yesBtn, findsOne);

      // cancels going home
      await t.tap(noBtn);
      await t.pumpAndSettle();
      expect(homeScreen, findsNothing);
      expect(detailsScreen, findsOne);

      // cancels going settings
      await t.tap(goSettingsBtn);
      await t.pumpAndSettle();
      await t.tap(noBtn);
      await t.pumpAndSettle();
      expect(detailsScreen, findsOne);

      // goes settings
      await t.tap(goSettingsBtn);
      await t.pumpAndSettle();
      await t.tap(yesBtn);
      await t.pumpAndSettle();
      expect(settingsScreen, findsOne);
      expect(goHomeBtn, findsOne);
      expect(goDetailsBtn, findsOne);
      expect(goSettingsBtn, findsNothing);

      // goes back home
      await t.tap(goHomeBtn);
      await t.pumpAndSettle();
      expect(homeScreen, findsOne);
    });
  });
}
