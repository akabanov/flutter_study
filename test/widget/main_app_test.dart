import 'package:flutter_study_skeleton_app/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Shows Hello World", (tester) async {
    await tester.pumpWidget(const MainApp());

    var text = find.text('Hello World!');
    expect(text, findsOne);
  });
}
