import 'package:vanilla/src/repo/repo_core.dart';

class FakeWebTodoRepo implements TodoRepo {
  static const todos = [
    TodoEntity(complete: true, id: '1', task: 'Rest', note: 'Thoroughly'),
    TodoEntity(complete: false, id: '2', task: 'Eat', note: ''),
    TodoEntity(
        complete: false, id: '3', task: 'Pet a cat', note: 'With respect'),
    TodoEntity(
        complete: false,
        id: '4',
        task: 'Repeat multiple times',
        note:
            'A note about necessity of being diligent and consistent in the matters of simple life pleasures.'),
  ];

  static const delay = Duration(milliseconds: 3000);

  var _todos = todos;

  @override
  Future<void> saveTodos(List<TodoEntity> todos) {
    return Future.delayed(delay, () => _todos = todos);
  }

  @override
  Future<List<TodoEntity>> loadTodos() {
    return Future.delayed(delay, () => _todos);
  }
}
