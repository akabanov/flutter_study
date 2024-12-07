import 'dart:async';

import 'package:vanilla/src/repo/repo_core.dart';

class CachingTodoRepo implements TodoRepo {
  final TodoRepo localRepo;
  final TodoRepo remoteRepo;

  CachingTodoRepo({required this.localRepo, required this.remoteRepo});

  @override
  Future<List<TodoEntity>> loadTodos() async {
    try {
      return await localRepo.loadTodos();
    } catch (ignored) {
      var todos = await remoteRepo.loadTodos();
      // optimistically ignore failures:
      localRepo.saveTodos(todos);
      return todos;
    }
  }

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    await Future.wait([
      localRepo.saveTodos(todos),
      remoteRepo.saveTodos(todos),
    ]);
  }
}
