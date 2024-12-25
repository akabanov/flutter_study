import 'package:flutter_test/flutter_test.dart';

void main() {
  group('simple asserts', () {
    test('implicit "equals" matcher', () {
      expect(10, 10);
    });

    test('explicit "equals" matcher', () {
      expect(10, equals(10));
    });

    test('compound "all" matcher', () {
      expect('foo,bar,buzz',
          allOf([startsWith('foo'), contains('bar'), endsWith('buzz')]));
    });
  });

  group('exceptions', () {
    test('specific exception', () {
      expect(() => throw StateError('here we are'), throwsStateError);
    });

    test('thrown text', () {
      expect(() => throw 'hmmm?', throwsA('hmmm?'));
    });

    test('thrown error by type', () {
      expect(() => int.parse('source'), throwsA(isA<FormatException>()));
    });
  });

  group('asynchronous expectations', () {
    test('future value: use `completion`', () {
      expect(Future.value(42), completion(42));
    });

    test('future failure: no need to wrap the matcher', () {
      expect(Future.error(StateError('bum!')), throwsStateError);
    });

    test('multi-calls', () {
      var stream = Stream.fromIterable([1, 2, 3]);
      stream.listen(expectAsync1((value) {
        expect(value, inInclusiveRange(1, 3));
      }, count: 3));
    });
  });

  group('streams', () {
    test('exact stream content', () {
      var stream = Stream.fromIterable([
        'HALO',
        'X-Http-Custom: abc',
        '',
        'Hello World!',
      ]);

      expect(
          stream,
          emitsInOrder([
            'HALO',
            emits(startsWith('X-')),
            emits(isEmpty),
            emitsAnyOf(['Hello World!', 'Hola']),
            emitsDone
          ]));
    });
  });
}
