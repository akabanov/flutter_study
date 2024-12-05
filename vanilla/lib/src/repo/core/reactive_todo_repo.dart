import 'package:vanilla/src/repo/core/todo_entity.dart';

abstract class ReactiveTodoRepo {
  Stream<List<TodoEntity>> getTodos();

  Future<void> addNewTodo(TodoEntity todo);

  Future<void> updateTodo(TodoEntity todo);

  Future<void> deleteTodos(List<String> idList);
}
