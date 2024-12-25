import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CounterHome extends StatelessWidget {
  CounterHome({required this.counterName})
      : super(key: Key('${counterName.toLowerCase()}-home-screen'));

  final String counterName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$counterName Counter Home'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () =>
                context.go('/${counterName.toLowerCase()}/counter'),
            child: Text('Go Count $counterName!')),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  Counter({required this.counterName})
      : super(key: Key('${counterName.toLowerCase()}-counter-screen'));

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
        title: Text('${widget.counterName} Counter'),
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
