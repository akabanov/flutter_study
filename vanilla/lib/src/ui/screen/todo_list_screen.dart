import 'package:flutter/material.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/static_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key, required this.todoListState});

  static const routeName = '/';

  final TodoListState todoListState;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    var state = widget.todoListState;

    if (state.status == TodoListStateStatus.error) {
      return StaticTodoScreen(
        child: Text(
          "Something went wrong.\n${state.error}",
          style: Theme.of(context).textTheme.displaySmall,
          textAlign: TextAlign.center,
        ),
      );
    }

    if (state.status == TodoListStateStatus.loading) {
      return StaticTodoScreen(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox.fromSize(size: Size(24, 24)),
          Text(
            "Loading Todo List",
            style: Theme.of(context).textTheme.displaySmall,
          )
        ],
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo list'),
      ),
      body: Placeholder(),
    );
  }
}
