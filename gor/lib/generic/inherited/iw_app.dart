import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class IWApp extends StatefulWidget {
  IWApp({super.key});

  static const from = 10;

  @override
  State<IWApp> createState() => _IWAppState();
}

class _IWAppState extends State<IWApp> {
  late final ValueNotifier<int> counter;
  late final StreamSubscription<int> subscription;

  @override
  void initState() {
    super.initState();
    counter = ValueNotifier(IWApp.from);
    subscription = Stream.periodic(
            const Duration(seconds: 1), (count) => IWApp.from - 1 - count)
        .take(IWApp.from)
        .listen((val) => counter.value = val);
  }

  @override
  void dispose() {
    subscription.cancel();
    counter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IWInheritedGreeting(
          child: IWCounterNotifier(
        notifier: counter,
        child: IWCounterDisplay(),
      )),
    );
  }
}

class IWInheritedGreeting extends InheritedWidget {
  const IWInheritedGreeting({
    super.key,
    required super.child,
  });

  final greeting = 'Hola!';

  static IWInheritedGreeting of(BuildContext context) {
    final IWInheritedGreeting? result =
        context.dependOnInheritedWidgetOfExactType<IWInheritedGreeting>();
    assert(result != null, 'No IWInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(IWInheritedGreeting oldWidget) {
    return greeting != oldWidget.greeting;
  }
}

class IWCounterNotifier extends InheritedNotifier<ValueNotifier<int>> {
  IWCounterNotifier({super.key, required super.notifier, required super.child});
}

class IWCounterDisplay extends StatelessWidget {
  const IWCounterDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inheritance study app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              IWInheritedGreeting.of(context).greeting,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Gap(24),
            Text(
              context
                      .dependOnInheritedWidgetOfExactType<IWCounterNotifier>()
                      ?.notifier
                      ?.value
                      .toString() ??
                  '?',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
