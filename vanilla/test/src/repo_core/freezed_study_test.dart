// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';

import 'freezed_entity.dart';

void main() {
  group('Freezed data objects study', () {
    test('Freezed implements equality', () async {
      expect(FreezedEntity(id: '42'), equals(FreezedEntity(id: '42')));
    });

    test('Freezed implements toString', () async {
      expect(FreezedEntity(id: '42').toString(), contains('42'));
    });
  });
}
