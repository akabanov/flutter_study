import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('widget finders', () {
    testWidgets('text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text('abc'),
          ),
        ),
      );

      var actual = find.text('abc');
      expect(actual, findsOne);
    });

    testWidgets('widget with text deep inside', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('hello'),
              ],
            ),
          ),
        ),
      );

      expect(find.widgetWithText(Text, 'hello'), findsNothing);
      // though:
      expect(
          find.ancestor(
              of: find.text('hello'),
              matching: find.byType(Text),
              matchRoot: true),
          findsOne);

      expect(find.widgetWithText(Column, 'hello'), findsOne);
      expect(find.widgetWithText(Scaffold, 'hello'), findsOne);
      expect(find.widgetWithText(MaterialApp, 'hello'), findsOne);
    });

    testWidgets('by icon', (tester) async {
      var iconData = Icons.important_devices;
      await tester.pumpWidget(MaterialApp(
        home: Row(
          children: [
            Icon(iconData),
            Text('abba'),
          ],
        ),
      ));

      expect(find.byIcon(iconData), findsOne);
      expect(find.widgetWithIcon(Row, iconData), findsOne);
      expect(find.widgetWithIcon(Row, Icons.abc), findsNothing);
      expect(find.widgetWithIcon(Column, iconData), findsNothing);
    });
  });
}
