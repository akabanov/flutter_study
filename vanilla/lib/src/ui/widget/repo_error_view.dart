import 'package:flutter/material.dart';

class RepoErrorView extends StatelessWidget {
  const RepoErrorView({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Text("Something went wrong.\n$errorMessage",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center));
  }
}
