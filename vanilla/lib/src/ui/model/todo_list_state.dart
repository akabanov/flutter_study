import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:vanilla/src/repo/repo_core.dart';

enum TodoListStateStatus { loading, error, ready }

class TodoListState extends Equatable {
  final TodoListStateStatus status;
  final List<TodoEntity> _todos;
  final String error;

  TodoListState(List<TodoEntity> todos)
      : status = TodoListStateStatus.ready,
        _todos = UnmodifiableListView(todos),
        error = '';

  const TodoListState.loading()
      : status = TodoListStateStatus.loading,
        _todos = const [],
        error = '';

  const TodoListState.error(this.error)
      : status = TodoListStateStatus.error,
        _todos = const [];

  List<TodoEntity> get todos {
    if (status != TodoListStateStatus.ready) {
      throw StateError(status.name);
    }
    return _todos;
  }

  @override
  List<Object> get props => [status, _todos, error];
}
