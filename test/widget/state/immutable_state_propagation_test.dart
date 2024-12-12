import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ImmutableCounter extends Equatable {
  final int value;

  const ImmutableCounter([this.value = 0]);

  ImmutableCounter increment() => ImmutableCounter(value + 1);

  String get stringValue => value.toString();

  @override
  String toString() => stringValue;

  @override
  List<Object> get props => [value];
}

////

typedef Incrementer = void Function();

////

class ImmutableCounterScreen extends StatelessWidget {
  const ImmutableCounterScreen(
      {super.key,
      required this.home,
      required this.counter,
      required this.incrementer});

  final bool home;
  final ImmutableCounter counter;
  final Incrementer incrementer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
        actions: home
            ? [
                IconButton(
                  key: Key('push'),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImmutableCounterScreen(
                          home: false,
                          counter: counter,
                          incrementer: incrementer))),
                  icon: Icon(Icons.navigate_next),
                ),
                IconButton(
                    key: Key('push-named'),
                    onPressed: () => Navigator.of(context).pushNamed('/named'),
                    icon: Icon(Icons.fast_forward))
              ]
            : [],
      ),
      body: Center(child: Text(counter.stringValue)),
      floatingActionButton: FloatingActionButton(
        key: Key('increment-$home'),
        onPressed: incrementer,
      ),
    );
  }
}

////

class ImmutableCounterApp extends StatefulWidget {
  const ImmutableCounterApp({super.key});

  @override
  State<ImmutableCounterApp> createState() => _ImmutableCounterAppState();
}

class _ImmutableCounterAppState extends State<ImmutableCounterApp> {
  ImmutableCounter counter = ImmutableCounter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImmutableCounterScreen(
          home: true, counter: counter, incrementer: increment),
      routes: {
        '/named': (context) => ImmutableCounterScreen(
            home: false, counter: counter, incrementer: increment),
      },
    );
  }

  void increment() {
    setState(() {
      counter = counter.increment();
    });
  }
}

////

void main() {
  group('Studying state propagation boundaries', () {
    testWidgets('Home page, immutable model', (t) async {
      await t.pumpWidget(const ImmutableCounterApp());

      // test initial state
      expect(find.text('0'), findsOne);

      // test increment on the home screen
      var homeIncButton = find.byKey(Key('increment-true'));
      await t.tap(homeIncButton);
      await t.pumpAndSettle();
      expect(find.text('1'), findsOne);

      // switch screen
      await t.tap(find.byKey(Key('push')));
      await t.pumpAndSettle();
      expect(find.text('1'), findsOne);
      expect(homeIncButton, findsNothing);

      // try the increment on the unnamed pushed screen
      await t.tap(find.byKey(Key('increment-false')));
      await t.pumpAndSettle();
      // it DOESN'T WORK: the screen is not rebuilt:
      expect(find.text('2'), findsNothing);

      // return to home screen and find the new counter value there:
      await t.pageBack();
      await t.pumpAndSettle();
      expect(find.text('2'), findsOne);

      // now let's push a named route
      var pushNamedButton = find.byKey(Key('push-named'));
      await t.tap(pushNamedButton);
      await t.pumpAndSettle();
      expect(pushNamedButton, findsNothing); // make sure we have left home :)
      expect(find.text('2'), findsOne);

      // try the increment on the named pushed screen
      await t.tap(find.byKey(Key('increment-false')));
      await t.pumpAndSettle();
      // IT WORKS! the app rebuilds the navigation stack
      expect(find.text('3'), findsOne);
    });
  });
}
