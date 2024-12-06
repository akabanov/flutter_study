import 'package:flutter/material.dart';
import 'package:vanilla/src/app.dart';
import 'package:vanilla/src/repo/local/fake_web_todo_repo.dart';

void main() async {
  var repo = FakeWebTodoRepo();
  runApp(App(todoRepo: repo));
}
