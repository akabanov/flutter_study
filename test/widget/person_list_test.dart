import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'person_list_test_app.dart';
import 'test_person.dart';

List<Person> generateFriends(int count) =>
    List.generate(count, (_) => Person.random());

void main() {
  group('person widgets interaction', () {
    testWidgets('scrolling to a particular person', (tester) async {
      var count = 100;
      var list = generateFriends(count);
      await tester.pumpWidget(PersonListTestApp(friends: list));

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
      var mainApp = PersonListTestApp(friends: friends);
      await tester.pumpWidget(mainApp);

      var redundant = friends.first;
      var tileFinder = find.byKey(Key(redundant.id));

      expect(mainApp.friends, contains(redundant));
      expect(tileFinder, findsOne);

      await tester.drag(tileFinder, Offset(-500, 10));
      await tester.pumpAndSettle();

      expect(mainApp.friends, isNot(contains(redundant)));
      expect(tileFinder, findsNothing);
    });

    testWidgets('adds a person', (tester) async {
      var mainApp = PersonListTestApp(friends: generateFriends(1));
      await tester.pumpWidget(mainApp);

      await tester.enterText(find.byType(TextField), 'Alex Kabanov');
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      expect(find.text('Alex Kabanov'), findsOne);
      expect(mainApp.friends.last.name, 'Alex Kabanov');
    });
  });
}
