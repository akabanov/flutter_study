import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoViewScreen extends StatelessWidget {
  static const k = Key('todo-view-screen');
  static const deleteBtnKey = Key('todo-view-screen-delete-btn');

  const TodoViewScreen(
      {super.key = k,
      required this.todoId,
      required this.updateTodo,
      required this.removeTodo});

  final String todoId;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  Widget build(BuildContext context) {
    var todo = Provider.of<TodoListState>(context, listen: true).get(todoId);
    return Scaffold(
      appBar: AppBar(
        title: Text('View task'),
        actions: [
          IconButton(
            key: deleteBtnKey,
            onPressed: () {
              removeTodo(todo);
              GoRouter.of(context).pop();
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
              onChanged: (complete) {
                todo = todo.copyWith(complete: complete ?? false);
                updateTodo(todo);
              },
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
