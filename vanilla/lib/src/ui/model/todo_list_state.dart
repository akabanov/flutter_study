import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:vanilla/src/repo/repo_core.dart';

typedef TodoAction = void Function(TodoEntity);

typedef TodoListAction = void Function(List<TodoEntity>);

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
    return _todos;
  }

  bool get ready => status == TodoListStateStatus.ready;

  TodoEntity? get(String id) =>
      todos.where((todo) => todo.id == id).firstOrNull;

  TodoListState copyWithNewTodo(TodoEntity todo) {
    if (todos.any((test) => test.id == todo.id)) {
      throw StateError('Adding duplicate todo id ${todo.id}');
    }
    return TodoListState([...todos, todo]);
  }

  TodoListState copyWithUpdatedTodo(TodoEntity update) {
    return TodoListState(
        todos.map((todo) => todo.id == update.id ? update : todo).toList());
  }

  TodoListState copyWithRemovedTodo(TodoEntity expired) {
    return TodoListState(todos.where((todo) => expired != todo).toList());
  }

  TodoListState copyWithOnlyIncomplete() {
    return TodoListState(todos.where((todo) => !todo.complete).toList());
  }

  int get activeTodos => todos.where((todo) => !todo.complete).length;

  int get completedTodos => todos.where((todo) => todo.complete).length;

  @override
  List<Object> get props => [status, _todos, error];
}
