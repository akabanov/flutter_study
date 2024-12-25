import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'counter_app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('app integration tests', () {
    testWidgets('counting numbers', (tester) async {
      await tester.pumpWidget(const TestCounterApp());

      expect(find.text('0'), findsOne);
      expect(find.text('1'), findsNothing);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOne);
    });
  });
}
