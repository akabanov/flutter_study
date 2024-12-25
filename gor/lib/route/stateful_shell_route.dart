import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gor/route/screen/conter.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

class StatefulShellRouteApp extends StatelessWidget {
  StatefulShellRouteApp({super.key});

  final router =
      GoRouter(debugLogDiagnostics: true, initialLocation: '/a', routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            StatefulShell(navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/a',
                builder: (context, state) => CounterHome(
                      counterName: 'A',
                    ),
                routes: [
                  GoRoute(
                    path: 'counter',
                    builder: (context, state) => Counter(
                      counterName: 'A',
                    ),
                  ),
                ]),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
                path: '/b',
                builder: (context, state) => CounterHome(
                      counterName: 'B',
                    ),
                routes: [
                  GoRoute(
                    path: 'counter',
                    builder: (context, state) => Counter(
                      counterName: 'B',
                    ),
                  ),
                ]),
          ]),
        ])
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Stateful Shell Test',
      routerConfig: router,
    );
  }
}

class StatefulShell extends StatelessWidget {
  StatefulShell(this.shell) : super(key: Key('app-shell'));

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final currentIndex = shell.currentIndex;

    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (idx) =>
            shell.goBranch(idx, initialLocation: idx == currentIndex),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'List',
            key: Key('a-nav-dest'),
          ),
          NavigationDestination(
            icon: Icon(Icons.query_stats),
            label: 'Stats',
            key: Key('b-nav-dest'),
          ),
        ],
      ),
    );
  }
}
