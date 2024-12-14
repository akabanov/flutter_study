import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/todo_view_screen.dart';

class TodoListItemTile extends StatelessWidget {
  const TodoListItemTile(
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
      child: ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => TodoViewScreen(
                  todo: todo,
                  updateTodo: updateTodo,
                  removeTodo: removeTodo,
                ))),
        leading: Checkbox(
          value: todo.complete,
          onChanged: (complete) => updateTodo(
            todo.copyWith(complete: complete ?? false),
          ),
        ),
        title: Text(
          todo.task,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: todo.note.isEmpty
            ? null
            : Text(
                todo.note,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
        // isThreeLine: false,
      ),
    );
  }
}
