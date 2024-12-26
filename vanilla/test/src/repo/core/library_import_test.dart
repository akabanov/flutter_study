import 'package:flutter_test/flutter_test.dart';
import 'package:vanilla/src/repo/repo_core.dart';

void main() {
  group('Checking how a library import works', () {
    test('TodoEntity is imported from "repo_core.dart"', () async {
      expect(
          const TodoEntity(
              complete: false, id: '42', task: 'Rest', note: 'Thoroughly'),
          isNot(null));
    });
  });
}
