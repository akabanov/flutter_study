import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockito_cat.dart';
@GenerateNiceMocks([MockSpec<Cat>()])
import 'mockito_test.mocks.dart';

final fails = throwsA(const TypeMatcher<TestFailure>());

class FakeCat extends Fake implements Cat {
  @override
  bool go(String destination) {
    return destination.isNotEmpty;
  }
}

void main() {
  group('verify the amount of interactions', () {
    test('never called', () {
      var cat = MockCat();
      verifyZeroInteractions(cat);

      cat.lives;
      expect(() => verifyZeroInteractions(cat), fails);
    });

    test('a method never called', () {
      var cat = MockCat();
      cat.go('places');
      verifyNever(cat.eat(any));
    });

    test('a method called once', () {
      var cat = MockCat();
      cat.eat('some food');
      verify(cat.eat(any));
      // second verification fails
      expect(() => verify(cat.eat(any)), fails);
    });

    test('a method called more than once: use count matcher', () {
      var cat = MockCat();
      cat.eat('carrot');
      cat.eat('grass');
      verify(cat.eat(any)).called(2);

      cat.eat('carrot');
      cat.eat('grass');
      verify(cat.eat(any)).called(inExclusiveRange(1, 3));
    });

    test('order of calls', () {
      var cat = MockCat();
      cat.eat('carrot');
      cat.eat('grass');
      cat.go('places');
      verifyInOrder([
        cat.eat(any),
        cat.eat(argThat(endsWith('ass'))),
        cat.go('places'),
      ]);
    });
  });

  group("let's stub!", () {
    test('stub getter', () {
      var cat = MockCat();
      when(cat.lives).thenReturn(42);
      expect(cat.lives, 42);
    });

    test('stub sync method', () {
      var cat = MockCat();
      when(cat.go('get some sleep')).thenReturn(true);
      expect(cat.go('get some sleep'), true);
    });

    test('stub throw', () {
      var cat = MockCat();
      when(cat.go(any)).thenThrow('no!');
      expect(() => cat.go('to work'), throwsA('no!'));
    });

    test('stub multiple values', () {
      var cat = MockCat();
      when(cat.lives).thenReturnInOrder([3, 2, 1]);
      expect(cat.lives, 3);
      expect(cat.lives, 2);
      expect(cat.lives, 1);
    });

    test('stub the future', () async {
      var cat = MockCat();
      when(cat.eat(any)).thenAnswer((_) async => true);
      expect(await cat.eat('mouse'), true);
    });

    test('stub a stream', () async {
      var cat = MockCat();
      when(cat.talk()).thenAnswer((_) => Stream.fromIterable(['guau']));
      expect(cat.talk(), emitsInOrder(['guau', emitsDone]));
    });

    test('stub a named parameter', () async {
      var cat = MockCat();
      when(cat.eat('carrot', hungry: argThat(isTrue, named: 'hungry')))
          .thenAnswer((_) async => true);
      when(cat.eat(any)).thenAnswer((_) async => false);
      expect(await cat.eat('carrot'), false);
      expect(await cat.eat('carrot', hungry: true), true);
    });

    test('stub conditionally', () async {
      var cat = MockCat();
      when(cat.eat(any, hungry: argThat(isFalse, named: 'hungry')))
          .thenThrow('no!');
      when(cat.eat(any, hungry: argThat(isTrue, named: 'hungry')))
          .thenAnswer((_) async => true);
      expect(() async => await cat.eat('something'), throwsA(anything));
      expect(await cat.eat('something', hungry: true), true);
    });
  });

  group('call arguments capturing', () {
    test('capture any', () {
      var cat = MockCat();
      cat.go('south');
      expect(verify(cat.go(captureAny)).captured.first, 'south');
    });

    test('capture many', () {
      var cat = MockCat();
      cat.go('north');
      cat.go('south');
      expect(verify(cat.go(captureAny)).captured, ['north', 'south']);
    });

    test('captureThat', () {
      var cat = MockCat();
      cat.go('north');
      cat.go('south');
      expect(
          verify(cat.go(captureThat(startsWith('s')))).captured.first, 'south');
    });

    test('captureNamed', () {
      var cat = MockCat();
      cat.eat('mouse', hungry: false);
      cat.eat('carrot', hungry: true);
      expect(verify(cat.eat(any, hungry: captureAnyNamed('hungry'))).captured,
          [false, true]);
    });
  });

  group('synchronisation', () {
    test('wait for a method to finish', () {
      var cat = MockCat();
      cat.go('places');
      untilCalled(cat.go(any)); // passes immediately
    });
  });

  group('cleanup', () {
    test('clear interactions', () {
      var cat = MockCat();

      expect(cat.go('somewhere'), isFalse);

      when(cat.go(any)).thenReturn(true);
      expect(cat.go('some place'), isTrue);

      cat.go('somewhere');

      clearInteractions(cat);
      verifyNever(cat.go(any));

      expect(cat.go('some place'), isTrue);
    });

    test('reset mock', () {
      var cat = MockCat();
      when(cat.go(any)).thenReturn(true);
      expect(cat.go('places'), isTrue);

      reset(cat);
      verifyZeroInteractions(cat);
      expect(cat.go('places'), isFalse);
    });
  });

  group('fake cat', () {
    test('can call implemented cases', () {
      var cat = FakeCat();
    expect(cat.go('somewhere'), isTrue);
    });

    test('fails when calling not implemented methods', () {
      var cat = FakeCat();
      expect(() => cat.lives, throwsUnimplementedError);
    });
  });
}
