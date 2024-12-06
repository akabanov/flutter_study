import 'package:flutter_test/flutter_test.dart';
import 'package:vanilla/src/repo/local/fake_web_todo_repo.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

void main() {
  group('Todo list state tests', () {
    test('Get todos throws error if state is not ready', () async {
      expect(() => TodoListState.loading().todos, throwsStateError);
      expect(() => TodoListState.error('error').todos, throwsStateError);
    });

    test('Get todos returns todos if ready', () {
      var todos = FakeWebTodoRepo.todos;
      expect(TodoListState(todos).todos, todos);
    });

    test('Get todos returns unmodifiable list', () async {
      var state = TodoListState([...FakeWebTodoRepo.todos]);

      expect(() => state.todos.removeLast(), throwsUnsupportedError);
    });
  });
}
