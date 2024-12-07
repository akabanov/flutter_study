import 'package:flutter/material.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';
import 'package:vanilla/src/ui/widget/loading_todo_list_view.dart';
import 'package:vanilla/src/ui/widget/repo_error_view.dart';
import 'package:vanilla/src/ui/widget/todo_list_view.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen(
      {super.key,
      required this.state,
      required this.addTodo,
      required this.updateTodo,
      required this.removeTodo});

  static const routeName = '/';

  final TodoListState state;
  final TodoAction addTodo;
  final TodoAction updateTodo;
  final TodoAction removeTodo;

  @override
  Widget build(BuildContext context) {
    return switch (state.status) {
      TodoListStateStatus.loading => LoadingTodoListView(),
      TodoListStateStatus.error => RepoErrorView(errorMessage: state.error),
      _ => TodoListView(
          state: state,
          addTodo: addTodo,
          updateTodo: updateTodo,
          removeTodo: removeTodo),
    };
  }
}
