import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gor/route/async_redirect.dart';

void main() {
  group('Widgets', () {
    test('Not logged in by default and no timers are created', () async {
      var streamAuth = StreamAuth();
      addTearDown(streamAuth.dispose);
      expect(streamAuth.user, isNull);
    });

    testWidgets('Authenticates in one second', (t) async {
      var streamAuth = StreamAuth(3);
      try {
        // must not change right after login
        streamAuth.login('Alex');
        expect(streamAuth.user, isNull);

        // must not change right before it must change
        await t.pump(const Duration(milliseconds: 999));
        expect(streamAuth.user, isNull);

        // changes in exact one second
        await t.pump(const Duration(milliseconds: 1));
        expect(streamAuth.user, 'Alex');

        // still signed in here
        await t.pump(const Duration(milliseconds: 2999));
        expect(streamAuth.user, 'Alex');

        // changes in exact one second
        await t.pump(const Duration(milliseconds: 1));
        expect(streamAuth.user, isNull);
      } finally {
        await t.pump(const Duration(minutes: 1));
        streamAuth.dispose();
      }
    });

    testWidgets('Auto-logout', (t) async {
      await t.pumpWidget(ARApp());

      try {
        // landed on login page when start
        expect(find.text('Login'), findsExactly(2));

        // still on login page, but now we're spinning
        await t.tap(find.byKey(const Key('login-btn')));
        await t.pump();
        expect(find.text('Login'), findsOne);
        expect(find.byType(CircularProgressIndicator), findsOne);

        // after one second we're home
        await t.pump(const Duration(seconds: 1));
        await t.pump();
        expect(find.byKey(const Key('home-screen')), findsOne);
        expect(find.textContaining('Alex'), findsOne);
        // here we are, the login screen is still lurking around:
        expect(find.byType(CircularProgressIndicator), findsOne);

        // and after 5 seconds we're signed off
        await t.pump(const Duration(milliseconds: 5000));
        // await t.pump(Duration(milliseconds: 4999));
        await t.pump();
        expect(find.text('Login'), findsExactly(2));
      } finally {
        await t.pump(const Duration(minutes: 1));
      }
    });

    testWidgets('Weird login screen duplication when using logout button',
        (t) async {
      await t.pumpWidget(ARApp());

      try {
        await t.tap(find.byKey(const Key('login-btn')));
        await t.pump(const Duration(seconds: 1));
        await t.pump();
        expect(find.byKey(const Key('home-screen')), findsOne);
        // this is really weird, login screen is still spinning:
        expect(find.byKey(const Key('login-screen')), findsOne);
        expect(find.byType(CircularProgressIndicator), findsOne);

        // sign out manually
        await t.tap(find.byKey(const Key('logout-btn')));
        // await t.pumpAndSettle(); // <-- times out!!!
        await t.pump(const Duration(milliseconds: 300));
        await t.pump();
        // 300ms later: one home and two login screens; login screens are with the same key, but different content.
        expect(find.byKey(const Key('home-screen')), findsOne);
        expect(find.byKey(const Key('login-screen')), findsExactly(2));

        // and 1ms later the former login screen disappears (home stays)
        await t.pump(const Duration(milliseconds: 1));
        expect(find.byKey(const Key('home-screen')), findsOne);
        expect(find.byKey(const Key('login-screen')), findsOne);
      } finally {
        await t.pump(const Duration(minutes: 1));
      }
    });
  });
}
