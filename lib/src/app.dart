import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Hello World!")),
        body: const Center(
          child: Text("How you're doing?"),
        ),
      ),
    );
  }
}
