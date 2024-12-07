import 'package:flutter/material.dart';
import 'package:vanilla/src/app.dart';
import 'package:vanilla/src/repo/repo_local.dart';

void main() async {
  var repo = CachingTodoRepo(
    localRepo: SharedPrefsTodoRepo(key: 'flutter-arch-todo'),
    remoteRepo: FakeWebTodoRepo(),
  );

  runApp(App(todoRepo: repo));
}
