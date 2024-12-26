import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/widget/content_loading_view.dart';

class TodoViewScreen extends StatefulWidget {
  static const routeName = 'viewTodo';

  static const k = Key('todo-view-screen');
  static const deleteBtnKey = Key('todo-view-screen-delete-btn');

  const TodoViewScreen({
    required this.todoId,
    required this.updateTodo,
    required this.removeTodo,
  }) : super(key: k);

  final String todoId;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  State<TodoViewScreen> createState() => _TodoViewScreenState();
}

class _TodoViewScreenState extends State<TodoViewScreen> {
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<TodoListState>(context, listen: true);

    TodoEntity? todo = state.get(widget.todoId);
    if (todo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('View task')),
        body: const ContentLoadingView(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('View task'),
        actions: [
          IconButton(
            key: TodoViewScreen.deleteBtnKey,
            onPressed: () => setState(() {
              widget.removeTodo(todo);
              context.pop();
            }),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: todo.complete,
              onChanged: (complete) => setState(() {
                widget.updateTodo(todo.copyWith(complete: complete ?? false));
              }),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(8),
                  Text(
                    todo.task,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Gap(16),
                  Text(todo.note),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
