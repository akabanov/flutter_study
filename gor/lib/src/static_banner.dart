import 'package:flutter/material.dart';

class StaticBanner extends StatelessWidget {
  const StaticBanner(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineMedium,);
  }
}
