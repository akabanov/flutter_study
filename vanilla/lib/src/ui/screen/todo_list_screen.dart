import 'package:flutter/material.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/screen/static_todo_screen.dart';
import 'package:vanilla/src/ui/widget/todo_list_item_view.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen(
      {super.key,
      required this.todoListState,
      required this.todoUpdater,
      required this.todoRemover,
      required this.todoAdder});

  static const routeName = '/';

  final TodoListState todoListState;
  final TodoAction todoAdder;
  final TodoAction todoUpdater;
  final TodoAction todoRemover;

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
      body: SafeArea(
        child: ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (_, index) => TodoListItemView(
              entity: state.todos[index],
              todoUpdater: widget.todoUpdater,
              todoRemover: widget.todoRemover),
        ),
      ),
    );
  }
}
