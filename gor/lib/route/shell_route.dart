import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gor/route/conter.dart';

final rootNavKey = GlobalKey<NavigatorState>();
final shellNavKey = GlobalKey<NavigatorState>();

class ShellRouteApp extends StatelessWidget {
  ShellRouteApp({super.key});

  final router =
      GoRouter(initialLocation: '/a', navigatorKey: rootNavKey, routes: [
    ShellRoute(
        navigatorKey: shellNavKey,
        builder: (context, state, child) =>
            ShellRouteAppScaffold(child, state.matchedLocation),
        routes: [
          GoRoute(
              path: '/a',
              builder: (context, state) =>
                  ShellRouteAppHome(keyName: 'a-screen', counterName: 'A'),
              routes: [
                GoRoute(
                  path: 'counter',
                  builder: (context, state) => Counter(counterName: 'A'),
                ),
              ]),
          GoRoute(
              path: '/b',
              builder: (context, state) =>
                  ShellRouteAppHome(keyName: 'b-screen', counterName: 'B'),
              routes: [
                GoRoute(
                  parentNavigatorKey: rootNavKey,
                  path: 'counter',
                  builder: (context, state) => Counter(counterName: 'B'),
                ),
              ]),
        ])
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shell Example',
      routerConfig: router,
    );
  }
}

class ShellRouteAppScaffold extends StatelessWidget {
  ShellRouteAppScaffold(this.child, this.location)
      : super(key: Key('app-shell'));

  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var index = switch (location) {
      String locationPath when locationPath.startsWith('/a') => 0,
      String locationPath when locationPath.startsWith('/b') => 1,
      _ => 0
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          destinations: [
            NavigationDestination(
              key: Key('a-tab-btn'),
              icon: Icon(Icons.list),
              label: 'First',
            ),
            NavigationDestination(
              key: Key('b-tab-btn'),
              icon: Icon(Icons.stacked_line_chart),
              label: 'Second',
            )
          ],
          onDestinationSelected: (i) {
            if (i != index) {
              context.go(i == 0 ? '/a' : '/b');
            }
          }),
    );
  }
}

class ShellRouteAppHome extends StatelessWidget {
  ShellRouteAppHome({required String keyName, required this.counterName})
      : counterLower = counterName.toLowerCase(),
        super(key: Key(keyName));

  final String counterName;
  final String counterLower;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$counterName Counter Home'),
      ),
      body: Center(
        child: ElevatedButton(
            key: Key('go-$counterLower-counter-btn'),
            onPressed: () => context.go('/$counterLower/counter'),
            child: Text('Go Count $counterName!')),
      ),
    );
  }
}
