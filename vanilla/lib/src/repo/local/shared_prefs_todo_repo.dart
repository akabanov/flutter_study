import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanilla/src/repo/repo_core.dart';

class SharedPrefsTodoRepo implements TodoRepo {
  final String _key;
  final SharedPreferencesAsync _prefs;

  SharedPrefsTodoRepo({required String key})
      : _key = key,
        _prefs = SharedPreferencesAsync();

  SharedPrefsTodoRepo.withPrefs(
      {required String key, required SharedPreferencesAsync prefs})
      : _key = key,
        _prefs = prefs;

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    var jsonEncoder = JsonEncoder();
    return _prefs.setStringList(_key,
        todos.map((todo) => todo.toJson()).map(jsonEncoder.convert).toList());
  }

  @override
  Future<List<TodoEntity>> loadTodos() async {
    var jsonDecoder = JsonDecoder();
    var list = await _prefs.getStringList(_key);

    if (list == null) {
      throw StateError('Nothing has been saved yet');
    }

    return list
        .map(jsonDecoder.convert)
        .map((json) => TodoEntity.fromJson(json))
        .toList();
  }

  Future<void> clear() async {
    return _prefs.remove(_key);
  }
}
