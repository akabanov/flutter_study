import 'package:flutter_test/flutter_test.dart';
import 'package:gor/generic/inherited/iw_app.dart';

void main() {
  group('Studying InheritedWidget', () {
    testWidgets('Checking greeting message', (t) async {
      await t.pumpWidget(IWApp());
      expect(find.text('Hola!'), findsOne);
    });

    testWidgets('Checking first counter tick', (t) async {
      await t.pumpWidget(IWApp());
      await t.pump(Duration(seconds: 1));
      expect(find.text('9'), findsOne);
    });

    testWidgets('Checking counter timing', (t) async {
      await t.pumpWidget(IWApp());
      expect(find.text('10'), findsOne);
      expect(find.text('9'), findsNothing);

      await t.pumpAndSettle(); // 'cost' 100ms by default
      expect(find.text('10'), findsOne);

      await t.pump(Duration(milliseconds: 899)); // 999 - 100
      expect(find.text('10'), findsOne);
      expect(find.text('9'), findsNothing);

      await t.pump(Duration(milliseconds: 1));
      expect(find.text('10'), findsNothing);
      expect(find.text('9'), findsOne);

      await t.pump(Duration(milliseconds: 999));
      expect(find.text('9'), findsOne);
      expect(find.text('8'), findsNothing);

      await t.pump(Duration(milliseconds: 1));
      expect(find.text('9'), findsNothing);
      expect(find.text('8'), findsOne);
    });
  });
}
