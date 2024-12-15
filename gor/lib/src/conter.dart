import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key, required this.counterName});

  final String counterName;

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> with RestorationMixin {
  final RestorableInt _counter = RestorableInt(0);

  @override
  String get restorationId => 'counter_screen';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_counter, 'counter');
  }

  @override
  void dispose() {
    _counter.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter.value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.counterName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
