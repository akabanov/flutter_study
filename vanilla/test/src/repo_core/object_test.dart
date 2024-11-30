// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';

final class WannaBeEntity {
  final String id;

  const WannaBeEntity(this.id);
}

@immutable
class ImmutableEntity {
  final String id;

  // no 'const' is intentional
  ImmutableEntity(this.id);
}

class EquatableEntity extends Equatable {
  final String id;

  EquatableEntity(this.id);

  @override
  List<Object> get props {
    return [id];
  }
}

void main() {
  group('Study equality/toString implementations', () {
    test('Const objects provide sameness', () {
      var obj1 = const WannaBeEntity('42');
      var obj2 = const WannaBeEntity('42');

      expect(obj1, same(obj2));
    });

    test('Full-final data class does not provide equality', () {
      expect(WannaBeEntity('42'), isNot(equals(WannaBeEntity('42'))));
    });

    test('Full-final data class does not provide toString', () {
      expect(WannaBeEntity('42').toString(), isNot(contains('42')));
    });

    test('@immutable does not provide equality', () async {
      expect(ImmutableEntity('42'), isNot(equals(ImmutableEntity('42'))));
    });

    test('@immutable does not provide toString', () async {
      expect(ImmutableEntity('42').toString(), isNot(contains('42')));
    });

    test('Equatable entity does provide equals()/hashCode()', () {
      expect(EquatableEntity('42'), equals(EquatableEntity('42')));
      expect(EquatableEntity('42').hashCode,
          equals(EquatableEntity('42').hashCode));
    });

    test('Equatable entity does provide toString() in debug mode', () {
      expect(EquatableEntity('42').toString(), contains('42'));
    });
  });
}
