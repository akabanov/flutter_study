import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gor/route/shell_route.dart';

void main() {
  group('Testing shell routes', () {
    testWidgets('Full path', (t) async {
      // shows 'A' tab initially (and there's no 'B' around)
      await t.pumpWidget(ShellRouteApp());
      expect(find.byKey(const Key('a-screen')), findsOne);
      expect(find.byKey(const Key('b-screen')), findsNothing);

      // 'go count' opens 'A' counter; shell is visible, counter is at zero
      await t.tap(find.byKey(const Key('go-a-counter-btn')));
      await t.pumpAndSettle();
      expect(find.byKey(const Key('app-shell')), findsOne);
      expect(find.text('0'), findsOne);

      // '+' button works
      await t.tap(find.byType(FloatingActionButton));
      await t.pumpAndSettle();
      expect(find.text('1'), findsOne);

      // switching back and forth exits counter
      await t.tap(find.byKey(const Key('b-tab-btn')));
      await t.pumpAndSettle();
      await t.tap(find.byKey(const Key('a-tab-btn')));
      await t.pumpAndSettle();
      expect(find.byKey(const Key('a-screen')), findsOne);

      // and also resets the counter state
      await t.tap(find.byKey(const Key('go-a-counter-btn')));
      await t.pumpAndSettle();
      expect(find.byKey(const Key('app-shell')), findsOne);
      expect(find.text('0'), findsOne);

      // 'B' tab content as expected:
      await t.tap(find.byKey(const Key('b-tab-btn')));
      await t.pumpAndSettle();
      expect(find.byKey(const Key('a-screen')), findsNothing);
      expect(find.byKey(const Key('b-screen')), findsOne);

      // there's no shell on the 'B' counter screen
      await t.tap(find.byKey(const Key('go-b-counter-btn')));
      await t.pumpAndSettle();
      expect(find.byKey(const Key('app-shell')), findsNothing);
      expect(find.text('0'), findsOne);
    });
  });
}
