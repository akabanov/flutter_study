import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Localization', () {
    testWidgets("Shows correct english title", (tester) async {
      await tester.pumpWidget(const MainApp());

      var text = find.text('Skeleton Study App');
      expect(text, findsOne);
    });

    testWidgets("Shows correct russian title", (tester) async {
      await tester.pumpWidget(const MainApp(
        locale: Locale('ru'),
      ));

      var text = find.text('Приложение для Изучения Skeleton App');
      expect(text, findsOne);
    });

    testWidgets('Shows correct greeting', (tester) async {
      await tester.pumpWidget(const MainApp());

      var text = find.text('Hello, Alex!');
      expect(text, findsOne);
    });
  });

  group('Unread message number l10n', () {
    var data = [
      (0, 'en', 'You have no unread messages'),
      (1, 'en', 'You have one unread message'),
      (2, 'en', 'You have 2 unread messages'),
      (3, 'en', 'You have 3 unread messages'),
      (0, 'ru', 'Нет непрочитанных сообщений'),
      (1, 'ru', '1 непрочитанное сообщение'),
      (21, 'ru', '21 непрочитанное сообщение'),
      (101, 'ru', '101 непрочитанное сообщение'),
      (1201, 'ru', '1201 непрочитанное сообщение'),
      (2, 'ru', '2 непрочитанных сообщений'), // бля...
      (10, 'ru', '10 непрочитанных сообщений'),
    ];

    for (var (n, localeName, message) in data) {
      var locale = Locale(localeName);
      testWidgets('Shows $n "unread messages" in $locale', (tester) async {
        await tester.pumpWidget(MainApp(locale: locale, unreadMessages: n));

        var text = find.text(message);
        expect(text, findsOne);
      });
    }
  });
}
