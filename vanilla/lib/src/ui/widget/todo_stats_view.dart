import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoStatsView extends StatelessWidget {
  TodoStatsView({super.key, required this.state})
      : completedTodos = state.todos.where((todo) => todo.complete).length;

  final TodoListState state;
  final int completedTodos;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Completed todos', style: textTheme.headlineLarge),
          const Gap(8),
          Text(state.completedTodos.toString(),
              style: textTheme.headlineMedium),
          const Gap(24),
          Text('Active todos', style: textTheme.headlineLarge),
          const Gap(8),
          Text(state.activeTodos.toString(), style: textTheme.headlineMedium),
        ],
      ),
    );
  }
}
