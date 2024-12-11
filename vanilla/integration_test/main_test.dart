import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vanilla/src/app.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/repo/local/in_memory_todo_repo.dart';
import 'package:vanilla/src/ui/screen/todo_view_screen.dart';
import 'package:vanilla/src/ui/widget/todo_list_item_tile.dart';
import 'package:vanilla/src/ui/widget/todo_list_view.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  App appWidget([List<TodoEntity> todos = const []]) {
    return App(
        todoRepo:
            InMemoryTodoRepo(latency: Duration(milliseconds: 10), seed: todos));
  }

  void screenshot(String name) async {
    await binding.convertFlutterSurfaceToImage();
    await binding.takeScreenshot(name);
  }

  var todos = [
    TodoEntity(complete: true, id: '42', task: 'Rest', note: 'Thoroughly'),
    TodoEntity(complete: false, id: '101', task: 'Work', note: 'Diligently'),
  ];

  group('App initialisation tests', () {
    testWidgets('Initial screen snapshot', (tester) async {
      runApp(appWidget());
      await tester.pumpAndSettle();

      screenshot('initial-screen');
    });

    testWidgets('Opens empty todo list by default', (tester) async {
      runApp(appWidget());
      await tester.pumpAndSettle();

      expect(find.text('Todo list'), findsOne);
      expect(find.byType(Scrollable), findsOne);
      expect(find.byType(TodoListItemTile), findsNothing);
    });

    testWidgets('Loads todos from the storage', (tester) async {
      runApp(appWidget(todos));
      await tester.pumpAndSettle();

      expect(find.byType(TodoListItemTile), findsExactly(2));
      expect(find.text('Rest'), findsOne);
      expect(find.text('Thoroughly'), findsOne);
    });

    testWidgets('Crops long task names and notes', (tester) async {
      var longName =
          'Repeat multiple times (just need a long enough task name)';
      var longNote =
          'A note about necessity of being diligent and consistent in the matters of simple life pleasures.';
      runApp(appWidget([
        TodoEntity(complete: false, id: '4', task: longName, note: longNote),
      ]));
      await tester.pumpAndSettle();

      var unboundTileText = find.descendant(
          of: find.byType(ListTile),
          matching: find.byWidgetPredicate(
              (text) => text is Text && text.maxLines == null));

      expect(unboundTileText, findsNothing);
    });

    testWidgets('Deletes todo by swiping and restores it using the snackbar',
        (tester) async {
      runApp(appWidget(todos));
      await tester.pumpAndSettle();

      await tester.drag(find.text('Rest'), Offset(200, 10));
      await tester.pumpAndSettle();

      expect(find.text('Rest'), findsNothing);
      expect(find.text('Work'), findsOne);

      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();

      expect(find.text('Rest'), findsOne);
      expect(find.text('Work'), findsOne);
    });

    testWidgets('Restoration: stats view', (tester) async {
      runApp(appWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(Key(TodoListTab.stats.navDestinationKey)));
      await tester.pumpAndSettle();

      expect(find.text('Completed todos'), findsOne);
      await tester.restartAndRestore();
      await tester.pumpAndSettle();

      expect(find.text('Completed todos'), findsOne);
    });

    testWidgets('Correct checkbox work in todo list', (tester) async {
      var app = appWidget(todos);
      runApp(app);
      await tester.pumpAndSettle();

      var restTile =
          find.ancestor(of: find.text('Rest'), matching: find.byType(ListTile));
      var restCheckbox = find.descendant(
          of: restTile,
          matching:
              find.byWidgetPredicate((w) => w is Checkbox && w.value == true));
      expect(restCheckbox, findsOne);

      var workTile =
          find.ancestor(of: find.text('Work'), matching: find.byType(ListTile));
      var workCheckbox = find.descendant(
          of: workTile,
          matching:
              find.byWidgetPredicate((w) => w is Checkbox && w.value == false));
      expect(workCheckbox, findsOne);

      await tester.tap(workCheckbox);
      await tester.pumpAndSettle();
      expect(workCheckbox, findsNothing);

      var list = await app.todoRepo.loadTodos();
      expect(list.length, 2);
      for (var todo in list) {
        expect(todo.complete, isTrue);
      }
    });

    testWidgets('Tap on todo opens todo view screen', (tester) async {
      runApp(appWidget(todos));
      await tester.pumpAndSettle();

      var restFinder = find.text('Rest');
      await tester.tap(restFinder);
      await tester.pumpAndSettle();

      expect(find.byKey(TodoViewScreen.k), findsOne);
      expect(restFinder, findsOne);
    });

    testWidgets('Restoration: path to todo view screen', (tester) async {
      runApp(appWidget());
      await tester.pumpAndSettle();
    }, skip: true);

    testWidgets('', (tester) async {
      runApp(appWidget());
      await tester.pumpAndSettle();
    }, skip: true);
  });
}
