import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/repo/repo_local.dart';

class MockSharedPreferencesAsync extends Mock
    implements SharedPreferencesAsync {}

void main() {
  const key = 'todos_test_prefs_key';
  var todos = [
    const TodoEntity(complete: true, id: '1', task: 'Rest', note: 'Thoroughly'),
    const TodoEntity(complete: false, id: '2', task: 'Eat', note: '')
  ];

  var encoder = const JsonEncoder();
  var todoJsonList = todos
      .map((todo) => todo.toJson())
      .map((json) => encoder.convert(json))
      .toList();

  group('Shared prefs tests', () {
    test('Stores list of correct JSON strings', () async {
      var mockPrefs = MockSharedPreferencesAsync();
      var sharedPrefsTodoRepo =
          SharedPrefsTodoRepo.withPrefs(key: key, prefs: mockPrefs);

      when(() => mockPrefs.setStringList(any(), any()))
          .thenAnswer((_) async {});
      sharedPrefsTodoRepo.saveTodos(todos);

      verify(() => mockPrefs.setStringList(key, todoJsonList)).called(1);
    });

    test('Retrieves todos from the prefs list', () async {
      var mockPrefs = MockSharedPreferencesAsync();
      var sharedPrefsTodoRepo =
          SharedPrefsTodoRepo.withPrefs(key: key, prefs: mockPrefs);
      when(() => mockPrefs.getStringList(key))
          .thenAnswer((_) => Future.value(todoJsonList));

      expect(await sharedPrefsTodoRepo.loadTodos(), todos);
    });
  });
}
