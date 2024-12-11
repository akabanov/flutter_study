import 'dart:collection';

import 'package:vanilla/src/repo/repo_core.dart';

class InMemoryTodoRepo implements TodoRepo {
  static const testData = [
    TodoEntity(complete: true, id: '1', task: 'Rest', note: 'Thoroughly'),
    TodoEntity(complete: false, id: '2', task: 'Eat', note: ''),
    TodoEntity(
        complete: false, id: '3', task: 'Pet a cat', note: 'With respect'),
    TodoEntity(
        complete: false,
        id: '4',
        task: 'Repeat multiple times (just need a long enough task name)',
        note:
            'A note about necessity of being diligent and consistent in the matters of simple life pleasures.'),
  ];

  static List<TodoEntity> sanitise(List<TodoEntity> todos) {
    Set<String> seen = {};
    assert(todos.every((todo) => seen.add(todo.id)));
    return UnmodifiableListView(todos);
  }

  final Duration latency;
  List<TodoEntity> _todos;

  InMemoryTodoRepo(
      {this.latency = const Duration(milliseconds: 50),
      List<TodoEntity> seed = const []})
      : _todos = sanitise(seed);

  InMemoryTodoRepo.withTestData(
      {this.latency = const Duration(milliseconds: 50)})
      : _todos = sanitise(testData);

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    // repo must guarantee save-load sync
    _todos = sanitise(todos);
    return Future.delayed(latency);
  }

  @override
  Future<List<TodoEntity>> loadTodos() {
    return Future.delayed(latency, () => _todos);
  }
}
