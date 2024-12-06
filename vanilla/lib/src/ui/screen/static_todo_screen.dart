import 'package:flutter/material.dart';

class StaticTodoScreen extends StatelessWidget {
  const StaticTodoScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo list"),
      ),
      body: Center(child: child),
    );
  }
}
