import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OEHomeScreen extends StatelessWidget {
  const OEHomeScreen() : super(key: const Key('home-screen'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => context.go('/details'),
                child: const Text('Go details'))
          ],
        ),
      ),
    );
  }
}

class OEDetailsScreen extends StatelessWidget {
  const OEDetailsScreen() : super(key: const Key('details-screen'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => context.go('/'), child: const Text('Go home')),
            TextButton(
                onPressed: () => context.go('/settings'),
                child: const Text('Go settings')),
          ],
        ),
      ),
    );
  }
}

class OESettingsScreen extends StatelessWidget {
  const OESettingsScreen() : super(key: const Key('settings-screen'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => context.go('/'), child: const Text('Go home')),
            TextButton(
                onPressed: () => context.goNamed('/details'),
                child: const Text('Go details')),
          ],
        ),
      ),
    );
  }
}

class OEApp extends StatelessWidget {
  OEApp({super.key});

  final _router = GoRouter(
      debugLogDiagnostics: true,
      restorationScopeId: 'router', // <-- restoration worked without this one
      routes: [
        GoRoute(path: '/', builder: (_, __) => const OEHomeScreen(), routes: [
          GoRoute(
            path: 'details',
            builder: (_, __) => const OEDetailsScreen(),
            // onExit: null,
            onExit: (context, _) async => await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirm'),
                contentPadding: const EdgeInsets.all(32),
                content: const Text('Sure you really want to exit??'),
                actions: [
                  TextButton(
                      key: const Key('no'),
                      onPressed: () => context.pop(false),
                      child: const Text('Not really')),
                  TextButton(
                      key: const Key('yes'),
                      onPressed: () => context.pop(true),
                      child: const Text('Definately!!'))
                ],
              ),
            ),
          ),
          GoRoute(path: 'settings', builder: (_, __) => const OESettingsScreen())
        ])
      ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router Study App',
      routerConfig: _router,
      restorationScopeId: 'app',
    );
  }
}
