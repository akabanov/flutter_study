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

      var text = find.text('Приложение для Изучения Skeleton');
      expect(text, findsOne);
    });

    testWidgets('Shows correct greeting', (tester) async {
      await tester.pumpWidget(const MainApp());

      var text = find.text('Hello, Alex!');
      expect(text, findsOne);
    });
  });

  group('Unread message number l10n', () {
    var data = {
      'en': [
        'You have no unread messages',
        'You have one unread message',
        'You have 2 unread messages',
        'You have 3 unread messages',
      ],
      'ru': [
        'Непрочитанных сообщений нет',
        'Непрочитанных сообщений: 1',
        'Непрочитанных сообщений: 2',
        'Непрочитанных сообщений: 3',
      ]
    };
    data.forEach((localeName, messages) {
      var locale = Locale(localeName);
      for (var (n, message) in messages.indexed) {
        testWidgets('Shows $n "unread messages" in $locale', (tester) async {
          await tester.pumpWidget(MainApp(locale: locale, unreadMessages: n));

          var text = find.text(message);
          expect(text, findsOne);
        });
      }
    });
  });
}
