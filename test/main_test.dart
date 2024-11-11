import 'package:flutter/cupertino.dart';
import 'package:flutter_study_skeleton_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Shows hello world", (tester) async {
    await tester.pumpWidget(const MainApp());

    // var text = find.text('Hello World!');
    var text = find.widgetWithText(Center, 'Hello World!');
    expect(text, findsOne);
  });
}