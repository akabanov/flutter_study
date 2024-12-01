import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vanilla/repo_core.dart';
import 'package:vanilla/src/repo_local/file_todo_repo.dart';

void main() {
  group('File based repo tests', () {
    var testDir = Directory.systemTemp.createTemp('todo_test_');
    var repo = FileTodoRepo(tag: 'test', getDirectory: () => testDir);
    var todos = [
      TodoEntity(complete: false, id: '42', task: 'Rest', note: 'Thoroughly')
    ];

    tearDownAll(() async {
      var dir = await testDir;
      dir.deleteSync(recursive: true);
    });

    test('Fails if no data exists', () async {
      expect(() => repo.loadTodos(), throwsException);
    });

    test('Saves todos', () async {
      var file = await repo.saveTodos(todos);

      expect(file.existsSync(), isTrue);
    });

    test('Loads todos', () async {
      var loaded = await repo.loadTodos();

      expect(loaded, todos);
    });
  });
}
