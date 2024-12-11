import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoViewScreen extends StatelessWidget {
  static const k = GlobalObjectKey('todo-view-screen');

  const TodoViewScreen(
      {super.key = k,
      required this.todo,
      required this.updateTodo,
      required this.removeTodo});

  final TodoEntity todo;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View task'),
        actions: [
          IconButton(
            onPressed: () {
              removeTodo(todo);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: todo.complete,
              onChanged: (complete) => updateTodo(
                todo.copyWith(complete: complete ?? false),
              ),
            ),
            Gap(16),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(8),
                Text(
                  todo.task,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Gap(16),
                Text(todo.note),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
