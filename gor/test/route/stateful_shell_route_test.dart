import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gor/route/stateful_shell_route.dart';

void main() {
  group('Stateful shell routing study', () {
    testWidgets('Full path', (t) async {
      await t.pumpWidget(StatefulShellRouteApp());
      expect(find.text('A Counter Home'), findsOne);

      var goACounterBtn = find.text('Go Count A!');
      await t.tap(goACounterBtn);
      await t.pumpAndSettle();
      expect(find.text('0'), findsOne);

      await t.tap(find.byType(FloatingActionButton));
      await t.pumpAndSettle();
      await t.tap(find.byType(FloatingActionButton));
      await t.pumpAndSettle();
      expect(find.text('2'), findsOne);

      await t.tap(find.text('Stats'));
      await t.pumpAndSettle();
      var goBCounterBtn = find.text('Go Count B!');
      expect(goBCounterBtn, findsOne);

      await t.tap(goBCounterBtn);
      await t.pumpAndSettle();
      expect(find.text('0'), findsOne);

      await t.tap(find.text('List'));
      await t.pumpAndSettle();
      expect(find.text('0'), findsNothing);
      expect(find.text('2'), findsOne);

      await t.tap(find.text('List'));
      await t.pumpAndSettle();
      expect(goACounterBtn, findsOne);

      // the counter is reset after moving to the branch root and back
      await t.tap(goACounterBtn);
      await t.pumpAndSettle();
      expect(find.text('0'), findsOne);
    });
  });
}
