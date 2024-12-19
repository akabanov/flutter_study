import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gor/route/sync_redirect.dart';

void main() {
  group('Sync redirect studying', () {
    testWidgets('Full route', (t) async {
      await t.pumpWidget(SRApp());
      expect(find.byKey(Key('home-screen')), findsNothing);
      expect(find.byKey(Key('login-screen')), findsOne);

      await t.tap(find.byKey(Key('login-btn')));
      await t.pumpAndSettle();
      expect(find.byKey(Key('home-screen')), findsOne);
      expect(find.byKey(Key('login-screen')), findsNothing);

      await t.tap(find.byKey(Key('logout-btn')));
      await t.pumpAndSettle();
      expect(find.byKey(Key('home-screen')), findsNothing);
      expect(find.byKey(Key('login-screen')), findsOne);
    });
  });
}
