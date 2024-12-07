import 'dart:collection';

import 'package:vanilla/src/repo/repo_core.dart';

class InMemoryTodoRepo implements TodoRepo {
  static const _testData = [
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

  final Duration latency;
  var _todos = const <TodoEntity>[];

  InMemoryTodoRepo({this.latency = const Duration(milliseconds: 50)});

  InMemoryTodoRepo.withTestData(
      {this.latency = const Duration(milliseconds: 50)})
      : _todos = UnmodifiableListView(_testData);

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    return Future.delayed(latency, () => _todos = UnmodifiableListView(todos));
  }

  @override
  Future<List<TodoEntity>> loadTodos() {
    return Future.delayed(latency, () => _todos);
  }
}
