import 'package:flutter_test/flutter_test.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

const todos = [
  TodoEntity(complete: true, id: '1', task: 'Rest', note: 'Thoroughly'),
  TodoEntity(complete: false, id: '2', task: 'Eat', note: ''),
  TodoEntity(complete: false, id: '3', task: 'Pet a cat', note: 'With respect'),
  TodoEntity(
      complete: false,
      id: '4',
      task: 'Repeat multiple times',
      note:
          'A note about necessity of being diligent and consistent in the matters of simple life pleasures.'),
];

void main() {
  group('Todo list status tests', () {
    test('Get todos returns todos if ready', () {
      expect(TodoListState(todos).todos, todos);
    });

    test('Get todos returns unmodifiable list', () async {
      var state = TodoListState([...todos]);

      expect(() => state.todos.removeLast(), throwsUnsupportedError);
    });

    test('Fails when adding a todo with an existing ID', () async {
      var dup =
          TodoEntity(complete: false, id: todos.last.id, task: 'Foo', note: '');

      expect(() => TodoListState(todos).copyWithNewTodo(dup), throwsStateError);
    });
  });

  group('Todo list statistics tests', () {
    test('Counts active todos', () async {
      expect(TodoListState(todos).activeTodos, 3);
    });

    test('Counts completed todos', () async {
      expect(TodoListState(todos).completedTodos, 1);
    });
  });

  group('Todo list update tests', () {
    test('Adds todo with a unique ID', () async {
      var newTodo = todos.first.copyWith(id: 'foo');

      expect(TodoListState(todos).copyWithNewTodo(newTodo).todos,
          [...todos, newTodo]);
    });

    test('Updates existing todo', () async {
      var update = todos.last.copyWith(complete: true, task: 'Bar');

      var actual = TodoListState(todos).copyWithUpdatedTodo(update).todos;
      expect(actual.length, todos.length);
      expect(actual.last, update);
    });

    test('Deletes todos', () {
      expect(TodoListState(todos).copyWithRemovedTodo(todos[1]).todos,
          isNot(contains(todos[1])));
    });

    test('Deletes completed', () async {
      var actual = TodoListState(todos).copyWithOnlyIncomplete().todos;

      expect(actual.length, 3);
      expect(actual, isNot(contains(todos.first)));
    });
  });
}
