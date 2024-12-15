import 'package:flutter/material.dart';

class ScaffoldMessengerAccess {
  static final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
      GlobalKey();

  static void tryShowSnackBar(SnackBar snackBar) =>
      rootScaffoldMessengerKey.currentState?.showSnackBar(snackBar);

  ScaffoldMessengerAccess._();
}
