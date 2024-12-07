import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vanilla/src/repo/local/caching_todo_repo.dart';
import 'package:vanilla/src/repo/repo_core.dart';

import 'caching_todo_repo_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodoRepo>()])
void main() {
  var todo = TodoEntity(complete: false, id: '123', task: 'Foo', note: 'bar');

  group('Caching repository tests', () {
    test('Loads from remote if local fails', () async {
      var localRepo = MockTodoRepo();
      var remoteRepo = MockTodoRepo();
      var repo = CachingTodoRepo(localRepo: localRepo, remoteRepo: remoteRepo);

      when(localRepo.loadTodos()).thenThrow(StateError('boo'));
      when(remoteRepo.loadTodos()).thenAnswer((_) => Future.value([todo]));

      expect(await repo.loadTodos(), [todo]);
      verify(localRepo.saveTodos([todo])).called(1);
    });

    test('Ignores remote if local succeeds', () async {
      var localRepo = MockTodoRepo();
      var remoteRepo = MockTodoRepo();
      var repo = CachingTodoRepo(localRepo: localRepo, remoteRepo: remoteRepo);

      when(localRepo.loadTodos()).thenAnswer((_) => Future.value([todo]));

      expect(await repo.loadTodos(), [todo]);
      verifyNever(remoteRepo.loadTodos());
      verifyNever(localRepo.saveTodos(captureAny));
    });

    test('Saves to both local and remote', () async {
      var localRepo = MockTodoRepo();
      var remoteRepo = MockTodoRepo();
      var repo = CachingTodoRepo(localRepo: localRepo, remoteRepo: remoteRepo);

      await repo.saveTodos([todo]);

      verify(remoteRepo.saveTodos([todo])).called(1);
      verify(localRepo.saveTodos([todo])).called(1);
    });
  });
}
