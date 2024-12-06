import 'package:vanilla/src/repo/repo_core.dart';

class FakeTodoRepo implements TodoRepo {
  static const todos = [
    TodoEntity(complete: false, id: '42', task: 'Rest', note: 'Thoroughly'),
  ];

  static const delay = Duration(milliseconds: 100);

  var _todos = todos;

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    return await Future.delayed(delay, () => _todos = todos);
  }

  @override
  Future<List<TodoEntity>> loadTodos() {
    return Future.delayed(delay, () => _todos);
  }
}
