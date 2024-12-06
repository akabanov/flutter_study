import 'package:vanilla/src/repo/core/todo_entity.dart';

abstract class ReactiveTodoRepo {
  Stream<List<TodoEntity>> getTodos();

  Future<void> addNewTodo(TodoEntity newTodo);

  Future<void> updateTodo(TodoEntity updatedTodo);

  Future<void> deleteTodos(List<String> idList);
}
