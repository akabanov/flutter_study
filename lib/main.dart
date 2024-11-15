import 'package:flutter/material.dart';
import 'package:flutter_study_skeleton_app/src/person/person.dart';

import 'src/app.dart';

void main() {
  runApp(MainApp(friends: List.generate(100, (_) => Person.random())));
}
