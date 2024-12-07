import 'package:flutter/material.dart';

class LoadingTodoListView extends StatelessWidget {
  const LoadingTodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Loading todo list')),
        body: Center(child: CircularProgressIndicator()));
  }
}
