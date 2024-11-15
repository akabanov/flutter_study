import 'package:flutter/cupertino.dart';
import 'package:flutter_study_skeleton_app/src/app.dart';
import 'package:flutter_study_skeleton_app/src/person/person.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('person widgets interaction', () {
    testWidgets('scrolling to a particular person', (tester) async {
      var count = 100;
      var list = List.generate(count, (_) => Person.random());
      await tester.pumpWidget(MainApp(friends: list));

      var last = list.last;
      var tileKey = Key(last.id);
      var tileFinder = find.byKey(tileKey);

      expect(tileFinder, findsNothing);

      await tester.scrollUntilVisible(tileFinder, 150, maxScrolls: count);

      expect(find.byKey(ValueKey(last.id)), findsOne);
    });
  });
}
