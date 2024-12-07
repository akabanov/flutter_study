import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoListItemView extends StatelessWidget {
  const TodoListItemView(
      {super.key,
      required this.todo,
      required this.updateTodo,
      required this.removeTodo});

  final TodoEntity todo;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('todo-list-item-${todo.id}'),
      onDismissed: (_) => removeTodo(todo),
      child: CheckboxListTile(
        value: todo.complete,
        onChanged: (complete) {
          if (complete != null) {
            updateTodo(todo.copyWith(complete: complete));
          }
        },
        title: Text(todo.task),
        subtitle: Text(todo.note),
        isThreeLine: true,
      ),
    );
  }
}
