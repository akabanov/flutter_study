import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vanilla/src/repo/repo_core.dart';
import 'package:vanilla/src/repo/repo_local.dart';

void main() {
  group('File repository for Todo entities', () {
    var todos = [
      TodoEntity(complete: true, id: '42', task: 'Rest', note: 'Fully')
    ];
    var tempDir = Directory.systemTemp.createTemp('todo_temp_');
    var repo = FileTodoRepo(tag: 'todo', getDirectory: () => tempDir);

    tearDownAll(() async {
      (await tempDir).deleteSync(recursive: true);
    });

    test('Fails if empty', () async {
      expect(() => repo.loadTodos(), throwsException);
    });

    test('Saves todos', () async {
      var file = await repo.saveTodos(todos);

      expect(file.existsSync(), isTrue);
    });

    test('Loads todos', () async {
      var actual = await repo.loadTodos();

      expect(actual, todos);
    });
  });
}
