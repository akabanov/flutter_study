import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:vanilla/src/app.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/repo/local/in_memory_todo_repo.dart';
import 'package:vanilla/src/ui/screen/todo_list_screen.dart';
import 'package:vanilla/src/ui/screen/todo_view_screen.dart';
import 'package:vanilla/src/ui/widget/todo_list_item_tile.dart';

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

  var todos = const [
    TodoEntity(complete: true, id: '42', task: 'Rest', note: 'Thoroughly'),
    TodoEntity(complete: false, id: '101', task: 'Work', note: 'Diligently'),
  ];

  group('App initialisation tests', () {
    testWidgets('Initial screen snapshot', (t) async {
      runApp(appWidget());
      await t.pumpAndSettle();

      screenshot('initial-screen');
    });

    testWidgets('Opens empty todo list by default', (t) async {
      runApp(appWidget());
      await t.pumpAndSettle();

      expect(find.text('Todo list'), findsOne);
      expect(find.byType(Scrollable), findsOne);
      expect(find.byType(TodoListItemTile), findsNothing);
    });

    testWidgets('Loads todos from the storage', (t) async {
      runApp(appWidget(todos));
      await t.pumpAndSettle();

      expect(find.byType(TodoListItemTile), findsExactly(2));
      expect(find.text('Rest'), findsOne);
      expect(find.text('Thoroughly'), findsOne);
    });

    testWidgets('Crops long task names and notes', (t) async {
      var longName =
          'Repeat multiple times (just need a long enough task name)';
      var longNote =
          'A note about necessity of being diligent and consistent in the matters of simple life pleasures.';
      runApp(appWidget([
        TodoEntity(complete: false, id: '4', task: longName, note: longNote),
      ]));
      await t.pumpAndSettle();

      var unboundTileText = find.descendant(
          of: find.byType(ListTile),
          matching: find.byWidgetPredicate(
              (text) => text is Text && text.maxLines == null));

      expect(unboundTileText, findsNothing);
    });

    testWidgets('Deletes todo by swiping and restores it using the snackbar',
        (t) async {
      runApp(appWidget(todos));
      await t.pumpAndSettle();

      await t.drag(find.text('Rest'), Offset(200, 10));
      await t.pumpAndSettle();

      expect(
          find.descendant(
              of: find.byType(ListTile), matching: find.text('Rest')),
          findsNothing);
      expect(find.text('Work'), findsOne);

      await t.tap(find.text('Undo'));
      await t.pumpAndSettle();

      expect(
          find.descendant(
              of: find.byType(ListTile), matching: find.text('Rest')),
          findsOne);
      expect(find.text('Work'), findsOne);
    });

    testWidgets('Stats view restoration', (t) async {
      runApp(appWidget());
      await t.pumpAndSettle();

      await t.tap(find.byKey(Key(TodoListTab.stats.navDestinationKey)));
      await t.pumpAndSettle();

      expect(find.text('Completed todos'), findsOne);
      await t.restartAndRestore();
      await t.pump();
      await t.pump();

      expect(find.text('Completed todos'), findsOne);
    });

    testWidgets('Correct checkbox work in todo list', (t) async {
      var app = appWidget(todos);
      runApp(app);
      await t.pumpAndSettle();

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

      await t.tap(workCheckbox);
      await t.pumpAndSettle();
      expect(workCheckbox, findsNothing);

      var list = await app.todoRepo.loadTodos();
      expect(list.length, 2);
      for (var todo in list) {
        expect(todo.complete, isTrue);
      }
    });

    testWidgets('Tap on todo opens todo view screen', (t) async {
      runApp(appWidget(todos));
      await t.pumpAndSettle();

      var restFinder = find.text('Rest');
      await t.tap(restFinder);
      await t.pumpAndSettle();

      expect(find.byKey(TodoViewScreen.k), findsOne);
      expect(restFinder, findsOne);
    });
  });

  group('Test todo view screen', () {
    testWidgets('Displays todo details', (t) async {
      var app = appWidget(todos);
      runApp(app);
      await t.pumpAndSettle();

      var todo = todos[0];
      await t.tap(find.text(todo.task));
      await t.pumpAndSettle();

      expect(find.byKey(TodoListScreen.k), findsNothing);
      expect(find.text('View task'), findsOne);
      expect(find.text(todo.task), findsOne);
      expect(find.text(todo.note), findsOne);
    });

    testWidgets('Checkbox works correctly', (t) async {
      var app = appWidget(todos);
      runApp(app);
      await t.pumpAndSettle();

      var todo = todos[0];
      await t.tap(find.text(todo.task));
      await t.pumpAndSettle();

      var checkbox =
          find.byWidgetPredicate((w) => w is Checkbox && w.value == true);
      expect(checkbox, findsOne);

      await t.tap(checkbox);
      await t.pumpAndSettle();

      expect(checkbox, findsNothing);
      var loaded = await app.todoRepo.loadTodos();
      expect(loaded[0].complete, isFalse);
    });

    testWidgets('Deletes todo and returns to the list screen', (t) async {
      var app = appWidget(todos);
      runApp(app);
      await t.pumpAndSettle();

      var todo = todos[0];
      await t.tap(find.text(todo.task));
      await t.pumpAndSettle();

      var deleteButton = find.byKey(TodoViewScreen.deleteBtnKey);
      await t.tap(deleteButton);
      await t.pumpAndSettle();

      expect(find.byKey(TodoListScreen.k), findsOne);
      expect(find.text('Undo'), findsOne);
      var loaded = await app.todoRepo.loadTodos();
      expect(loaded, isNot(contains(todo)));
    });

    testWidgets('Restoration: path to todo view screen', (t) async {
      runApp(appWidget(todos));
      await t.pumpAndSettle();

      var todo = todos[0];
      await t.tap(find.text(todo.task));
      await t.pumpAndSettle();
      expect(find.byKey(TodoViewScreen.k), findsOne);
      expect(find.text(todo.task), findsOne);

      await t.restartAndRestore();
      await t.pumpAndSettle();

      expect(find.byKey(TodoViewScreen.k), findsOne);
      expect(find.text(todo.task), findsOne);
      expect(find.text(todo.note), findsOne);
    });
  });

  group('Create todo tests', () {
    testWidgets('Opens new todo screen from todo list screen', (t) async {
      runApp(appWidget());
      await t.pumpAndSettle();

      await t.tap(find.byKey(Key('add-todo-btn')));
      await t.pumpAndSettle();
      expect(find.text('Add todo'), findsOne);
    });

    testWidgets('Creates todo and returns to todo list', (t) async {
      runApp(appWidget());
      await t.pumpAndSettle();
      await t.tap(find.byKey(Key('add-todo-btn')));
      await t.pumpAndSettle();

      var saveButton = find.byKey(Key('save-todo-btn'));
      var taskFormField = find.byKey(Key('todo-task-form-field'));

      // Verify that the save button is disabled when no task name is entered
      expect(t.widget<FloatingActionButton>(saveButton).onPressed, isNull);

      // Verify that the save button is disabled when empty text is entered
      await t.enterText(taskFormField, '  \n  ');
      await t.pumpAndSettle();
      expect(t.widget<FloatingActionButton>(saveButton).onPressed, isNull);

      // Enter a valid task name and verify the save button becomes enabled
      await t.enterText(taskFormField, 'New Task');
      await t.pumpAndSettle();
      expect(t.widget<FloatingActionButton>(saveButton).onPressed, isNotNull);

      // Verify that the save button is disabled again when empty text is entered
      await t.enterText(taskFormField, ' ');
      await t.pumpAndSettle();
      expect(t.widget<FloatingActionButton>(saveButton).onPressed, isNull);

      // Enter a valid task name again
      await t.enterText(taskFormField, 'New Task');
      await t.pumpAndSettle();
      expect(t.widget<FloatingActionButton>(saveButton).onPressed, isNotNull);

      await t.tap(saveButton);
      await t.pumpAndSettle();
      expect(find.text('Todo list'), findsOne);
      expect(find.text('New Task'), findsOne);
    });

    testWidgets('Preserves entered values on restore', (t) async {
      runApp(appWidget());
      await t.pumpAndSettle();
      await t.tap(find.byKey(Key('add-todo-btn')));
      await t.pump();
      await t.pump();

      var taskFormField = find.byKey(Key('todo-task-form-field'));
      await t.enterText(taskFormField, 'New Task');
      await t.pumpAndSettle();
      expect(find.text('New Task'), findsOne);

      await t.restartAndRestore();
      expect(find.text('Add todo'), findsOne);
      expect(find.text('New Task'), findsOne);
    });
  });
}
