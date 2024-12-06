import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vanilla/src/repo/repo_core.dart';

class RxTodoRepo implements ReactiveTodoRepo {
  final TodoRepo _repo;
  final BehaviorSubject<List<TodoEntity>> _subject;
  bool _loaded;

  RxTodoRepo(TodoRepo repo, [List<TodoEntity>? seed])
      : _repo = repo,
        _loaded = (seed != null),
        _subject = (seed != null)
            ? BehaviorSubject.seeded(seed)
            : BehaviorSubject<List<TodoEntity>>();

  @override
  Stream<List<TodoEntity>> getTodos() {
    // can't rely on _repo.hasValue
    if (!_loaded) {
      _load();
    }
    return _subject.stream;
  }

  void _load() async {
    _loaded = true;
    _subject.add(await _repo.loadTodos());
  }

  @override
  Future<void> deleteTodos(List<String> idList) async {
    return _update((list) => list
        .where((entity) => !idList.contains(entity.id))
        .toList(growable: false));
  }

  @override
  Future<void> updateTodo(TodoEntity update) async {
    return _update((list) => list
        .map((entity) => entity.id == update.id ? update : entity)
        .toList(growable: false));
  }

  @override
  Future<void> addNewTodo(TodoEntity newTodo) async {
    return _update((list) {
      if (list.any((todo) => todo.id == newTodo.id)) {
        throw StateError('Adding a todo with exising ID: $newTodo');
      }
      return [...list, newTodo];
    });
  }

  Future<void> _update(
      List<TodoEntity> Function(List<TodoEntity>) updater) async {
    if (!_subject.hasValue) {
      throw StateError('Updating repository before it has been loaded');
    }
    var list = _subject.value;
    var newList = updater(list);
    _subject.add(newList);
    _repo.saveTodos(newList);
  }
}
