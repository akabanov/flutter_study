import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mockito_cat.dart';
@GenerateNiceMocks([MockSpec<Cat>()])
import 'mockito_test.mocks.dart';

final fails = throwsA(const TypeMatcher<TestFailure>());

class FakeCat extends Fake implements Cat {
  //
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
}
