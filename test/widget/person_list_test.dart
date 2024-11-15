import 'package:flutter/cupertino.dart';
import 'package:flutter_study_skeleton_app/src/app.dart';
import 'package:flutter_study_skeleton_app/src/person/person.dart';
import 'package:flutter_test/flutter_test.dart';

List<Person> generateFriends(int count) =>
    List.generate(count, (_) => Person.random());

void main() {
  group('person widgets interaction', () {
    testWidgets('scrolling to a particular person', (tester) async {
      var count = 100;
      var list = generateFriends(count);
      await tester.pumpWidget(MainApp(friends: list));

      var tileFinder = find.byKey(Key(list.last.id));
      expect(tileFinder, findsNothing);

      await tester.scrollUntilVisible(tileFinder, 150,
          maxScrolls: count,
          scrollable: find.descendant(
              of: find.byKey(Key('people_list')),
              matching: find.byType(Scrollable)));

      expect(tileFinder, findsOne);
    });

    testWidgets('deletes a person on swipe', (tester) async {
      var friends = generateFriends(2);
      await tester.pumpWidget(MainApp(friends: friends));

      var tileFinder = find.byKey(Key(friends.first.id));
      await tester.drag(tileFinder, Offset(-500, 10));
      await tester.pumpAndSettle();

      expect(tileFinder, findsNothing);
    });
  });
}
