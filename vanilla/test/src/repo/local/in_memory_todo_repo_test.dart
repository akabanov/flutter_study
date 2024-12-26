import 'package:flutter_test/flutter_test.dart';
import 'package:vanilla/src/repo/core/todo_entity.dart';
import 'package:vanilla/src/repo/local/in_memory_todo_repo.dart';

void main() {
  group('In-memory repo checks for duplicate ID', () {
    const rotten = [
      TodoEntity(complete: false, id: '13', task: 'One', note: ''),
      TodoEntity(complete: false, id: '13', task: 'Two', note: ''),
    ];

    test('Constructor throws if seed has duplicates', () async {
      expect(() => InMemoryTodoRepo(seed: rotten), throwsAssertionError);
    });

    test('"Save" throws if seed has duplicates', () async {
      expect(() => InMemoryTodoRepo(latency: Duration.zero).saveTodos(rotten),
          throwsAssertionError);
    });

    test('Initialises with test data', () async {
      expect(() => InMemoryTodoRepo.withTestData(), returnsNormally);
    });

    test('Initialises with empty data', () async {
      expect(() => InMemoryTodoRepo(seed: []), returnsNormally);
    });

    test('Initialises with good data', () async {
      expect(
          () => InMemoryTodoRepo(seed: [
                const TodoEntity(
                    complete: false, id: '13', task: 'One', note: ''),
                const TodoEntity(
                    complete: false, id: '14', task: 'Two', note: ''),
              ]),
          returnsNormally);
    });
  });
}
