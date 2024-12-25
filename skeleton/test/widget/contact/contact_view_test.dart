import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/contact/contact.dart';
import 'package:flutter_study_skeleton_app/src/contact/contact_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Contact view tests', () {
    testWidgets('Contact view shows contact Id', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ContactView(
            contact: Contact(id: 42),
          ),
        ),
      );

      expect(find.textContaining('42'), findsAtLeast(1));
    });
  });
}
