import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/repo/repo_local.dart';

class MockTodoRepo extends Mock implements TodoRepo {}

void main() {
  group('RX todo entity repo tests', () {
    var todos = [
      const TodoEntity(
          complete: true, id: '1', task: 'Rest', note: 'Thoroughly')
    ];
    var originalTodo = todos.first;
    var updatedTodo = originalTodo.copyWith(complete: !originalTodo.complete);
    var newTodo =
        const TodoEntity(complete: false, id: '12', task: 'Enjoy', note: '');

    late MockTodoRepo mockTodoRepo;

    setUp(() {
      mockTodoRepo = MockTodoRepo();
      when(() => mockTodoRepo.saveTodos(any())).thenAnswer((_) async {});
    });

    test('Loads todos exactly once', () async {
      var mockRepo = mockTodoRepo;
      var repo = RxTodoRepo(mockRepo);
      when(() => mockRepo.loadTodos()).thenAnswer((_) => Future.value(todos));

      expect(repo.getTodos(), emits(todos));
      expect(repo.getTodos(), emits(todos));
      verify(() => mockRepo.loadTodos()).called(1);
    });

    test('Fails when adding todo with existing ID', () async {
      var repo = RxTodoRepo(mockTodoRepo, todos);

      expect(() => repo.addNewTodo(originalTodo), throwsStateError);
    });

    test('Fails when modified before loaded', () async {
      var repo = RxTodoRepo(mockTodoRepo);

      expect(() => repo.addNewTodo(newTodo), throwsStateError);
    });

    test('Adds todos', () async {
      var repo = RxTodoRepo(mockTodoRepo, todos);
      await repo.addNewTodo(newTodo);

      expect(repo.getTodos(), emits([...todos, newTodo]));
    });

    test('Updates todos', () async {
      var repo = RxTodoRepo(mockTodoRepo, todos);
      await repo.updateTodo(updatedTodo);

      expect(repo.getTodos(), emits([updatedTodo]));
    });

    test('Deletes todo', () async {
      var repo = RxTodoRepo(mockTodoRepo, todos);
      await repo.deleteTodos([originalTodo.id]);

      expect(repo.getTodos(), emits([]));
    });

    test('Does not delete non-matching todos', () async {
      var repo = RxTodoRepo(mockTodoRepo, todos);
      await repo.deleteTodos(['foo']);

      expect(repo.getTodos(), emits(todos));
    });
  });
}
