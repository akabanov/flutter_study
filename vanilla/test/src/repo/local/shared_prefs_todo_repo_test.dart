import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanilla/src/repo/local/fake_web_todo_repo.dart';
import 'package:vanilla/src/repo/local/shared_prefs_todo_repo.dart';

import 'shared_prefs_todo_repo_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferencesAsync>()])
void main() {
  const key = 'todos_test_prefs_key';
  var todos = FakeWebTodoRepo.todos;

  var encoder = JsonEncoder();
  var todoJsonList = todos
      .map((todo) => todo.toJson())
      .map((json) => encoder.convert(json))
      .toList();

  group('Shared prefs tests', () {
    test('Stores list of correct JSON strings', () async {
      var mockPrefs = MockSharedPreferencesAsync();
      var sharedPrefsTodoRepo = SharedPrefsTodoRepo(key: key, prefs: mockPrefs);
      sharedPrefsTodoRepo.saveTodos(todos);

      verify(mockPrefs.setStringList(key, todoJsonList)).called(1);
    });

    test('Retrieves todos from the prefs list', () async {
      var mockPrefs = MockSharedPreferencesAsync();
      var sharedPrefsTodoRepo = SharedPrefsTodoRepo(key: key, prefs: mockPrefs);
      when(mockPrefs.getStringList(key))
          .thenAnswer((_) => Future.value(todoJsonList));

      expect(await sharedPrefsTodoRepo.loadTodos(), todos);
    });
  });
}
