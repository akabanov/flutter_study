import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vanilla/src/repo/local/caching_todo_repo.dart';
import 'package:vanilla/src/repo/repo_core.dart';

class MockTodoRepo extends Mock implements TodoRepo {}

void main() {
  var todo =
      const TodoEntity(complete: false, id: '123', task: 'Foo', note: 'bar');

  group('Caching repository tests', () {
    test('Loads from remote if local fails', () async {
      var localRepo = MockTodoRepo();
      var remoteRepo = MockTodoRepo();
      var repo = CachingTodoRepo(localRepo: localRepo, remoteRepo: remoteRepo);

      when(() => localRepo.loadTodos()).thenThrow(StateError('boo'));
      when(() => remoteRepo.loadTodos())
          .thenAnswer((_) => Future.value([todo]));

      when(() => localRepo.saveTodos(any())).thenAnswer((_) async {});
      when(() => remoteRepo.saveTodos(any())).thenAnswer((_) async {});

      expect(await repo.loadTodos(), [todo]);
      verify(() => localRepo.saveTodos([todo])).called(1);
    });

    test('Ignores remote if local succeeds', () async {
      var localRepo = MockTodoRepo();
      var remoteRepo = MockTodoRepo();
      var repo = CachingTodoRepo(localRepo: localRepo, remoteRepo: remoteRepo);

      when(() => localRepo.loadTodos()).thenAnswer((_) => Future.value([todo]));

      expect(await repo.loadTodos(), [todo]);
      verifyNever(() => remoteRepo.loadTodos());
      verifyNever(() => localRepo.saveTodos(captureAny()));
    });

    test('Saves to both local and remote', () async {
      var localRepo = MockTodoRepo();
      var remoteRepo = MockTodoRepo();
      var repo = CachingTodoRepo(localRepo: localRepo, remoteRepo: remoteRepo);

      when(() => localRepo.saveTodos(any())).thenAnswer((_) async {});
      when(() => remoteRepo.saveTodos(any())).thenAnswer((_) async {});

      await repo.saveTodos([todo]);

      verify(() => remoteRepo.saveTodos([todo])).called(1);
      verify(() => localRepo.saveTodos([todo])).called(1);
    });
  });
}
