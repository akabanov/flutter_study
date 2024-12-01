import 'package:vanilla/src/repo_core/todo_entity.dart';

abstract class TodoRepo {
  Future<List<TodoEntity>> loadTodos();

  Future<void> saveTodos(List<TodoEntity> todos);
}
