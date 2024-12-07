import 'package:flutter/material.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/ui/model/todo_list_state.dart';

class TodoListItemView extends StatelessWidget {
  const TodoListItemView(
      {super.key,
      required this.entity,
      required this.todoUpdater,
      required this.todoRemover});

  final TodoEntity entity;
  final TodoAction todoUpdater;
  final TodoAction todoRemover;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('todo-list-item-${entity.id}'),
      onDismissed: (_) => todoRemover(entity),
      child: CheckboxListTile(
        value: entity.complete,
        onChanged: (complete) {
          if (complete != null) {
            todoUpdater(entity.copyWith(complete: complete));
          }
        },
        title: Text(entity.task),
        subtitle: Text(entity.note),
        isThreeLine: true,
      ),
    );
  }
}
