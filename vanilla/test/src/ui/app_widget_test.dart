import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vanilla/src/app.dart';
import 'package:vanilla/src/repo/local/in_memory_todo_repo.dart';

void main() {
  var repo = InMemoryTodoRepo();

  group('App initialisation tests', () {
    setUp(() async {
      repo.saveTodos([]);
    });

    testWidgets('Opens empty todo list by default', (tester) async {
      await tester.pumpWidget(App(todoRepo: repo));
      await tester.pumpAndSettle();

      expect(find.text('Todo list'), findsOne);
      expect(find.byType(Scrollable), findsOne);
    });
  });
}
