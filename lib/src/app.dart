import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import 'l10n/l10n.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.locale = const Locale('en')});

  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routes: {
        '/': (context) => Scaffold(
              appBar: AppBar(title: Text(L10n.of(context).appTitle)),
              body: Center(
                child: Text(L10n.of(context).greeting("Alex")),
              ),
            ),
      },
    );
  }
}
