import 'dart:collection';

import 'package:vanilla/src/repo/repo_core.dart';

class InMemoryTodoRepo implements TodoRepo {
  var _todos = const <TodoEntity>[];

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    _todos = UnmodifiableListView(todos);
  }

  @override
  Future<List<TodoEntity>> loadTodos() {
    return Future.value(_todos);
  }
}
