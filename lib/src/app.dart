import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'l10n/l10n.dart';

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key,
      this.locale = const Locale('en'),
      this.unreadMessages = 0});

  final Locale locale;
  final int unreadMessages;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(L10n.of(context).appTitle)),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(L10n.of(context).greeting("Alex")),
                Text(L10n.of(context).unreadMessages(unreadMessages))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
