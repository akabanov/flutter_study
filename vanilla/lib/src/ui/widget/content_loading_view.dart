import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ContentLoadingView extends StatelessWidget {
  const ContentLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const Gap(24),
          Text(
            'Loading...',
            style: Theme.of(context).textTheme.headlineMedium,
          )
        ],
      ),
    );
  }
}
