import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vanilla/src/repo/local/fake_web_todo_repo.dart';
import 'package:vanilla/src/repo/local/rx_todo_repo.dart';
import 'package:vanilla/src/repo/repo_core.dart';

import 'rx_todo_repo_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoRepo>()])
void main() {
  group('RX todo entity repo tests', () {
    var todos = [FakeWebTodoRepo.todos.first];
    var originalTodo = todos.first;
    var updatedTodo = originalTodo.copyWith(complete: !originalTodo.complete);
    var newTodo =
        TodoEntity(complete: false, id: '12', task: 'Enjoy', note: '');

    test('Loads todos exactly once', () async {
      var mockRepo = MockTodoRepo();
      var repo = RxTodoRepo(mockRepo);
      when(mockRepo.loadTodos()).thenAnswer((_) => Future.value(todos));

      expect(repo.getTodos(), emits(todos));
      expect(repo.getTodos(), emits(todos));
      verify(mockRepo.loadTodos()).called(1);
    });

    test('Fails when adding todo with existing ID', () async {
      var repo = RxTodoRepo(MockTodoRepo(), todos);

      expect(() => repo.addNewTodo(originalTodo), throwsStateError);
    });

    test('Fails when modified before loaded', () async {
      var repo = RxTodoRepo(MockTodoRepo());

      expect(() => repo.addNewTodo(newTodo), throwsStateError);
    });

    test('Adds todos', () async {
      var repo = RxTodoRepo(MockTodoRepo(), todos);
      await repo.addNewTodo(newTodo);

      expect(repo.getTodos(), emits([...todos, newTodo]));
    });

    test('Updates todos', () async {
      var repo = RxTodoRepo(MockTodoRepo(), todos);
      await repo.updateTodo(updatedTodo);

      expect(repo.getTodos(), emits([updatedTodo]));
    });

    test('Deletes todo', () async {
      var repo = RxTodoRepo(MockTodoRepo(), todos);
      await repo.deleteTodos([originalTodo.id]);

      expect(repo.getTodos(), emits([]));
    });

    test('Does not delete non-matching todos', () async {
      var repo = RxTodoRepo(MockTodoRepo(), todos);
      await repo.deleteTodos(['foo']);

      expect(repo.getTodos(), emits(todos));
    });
  });
}
