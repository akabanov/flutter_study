import 'package:flutter_study_skeleton_app/src/contact/contact.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Contact data model tests', () {
    test('Assigns ID', () async {
      expect(Contact(id: 5).id, 5);
    });

    test('ToString has ID', () async {
      expect(Contact(id: 42).toString(), contains('42'));
    });
  });
}
