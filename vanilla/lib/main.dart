import 'package:flutter/material.dart';
import 'package:vanilla/src/app.dart';
import 'package:vanilla/src/repo/repo_local.dart';

void main() async {
  var repo = FakeWebTodoRepo();
  runApp(App(todoRepo: repo));
}
