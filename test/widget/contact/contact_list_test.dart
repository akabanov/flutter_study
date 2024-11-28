import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/contact/contact_list.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Contact list screen test', () {
    createList() => MaterialApp(home: ContactList());

    testWidgets('Shows contacts, avatars and settings button', (tester) async {
      await tester.pumpWidget(createList());

      expect(find.textContaining('1'), findsOne);
      expect(find.textContaining('2'), findsOne);
      expect(find.byIcon(Icons.settings), findsOne);
      expect(find.byType(CircleAvatar), findsExactly(2));
    });
  });
}
