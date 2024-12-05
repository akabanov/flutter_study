import 'package:vanilla/src/repo/core/todo_entity.dart';

abstract class TodoRepo {
  Future<void> saveTodos(List<TodoEntity> todos);

  Future<List<TodoEntity>> loadTodos();
}
