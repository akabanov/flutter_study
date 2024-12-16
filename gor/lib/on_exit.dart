import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OEHomeScreen extends StatelessWidget {
  const OEHomeScreen() : super(key: const Key('home-screen'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => context.go('/details'),
                child: Text('Go details'))
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
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => context.go('/'), child: Text('Go home')),
            TextButton(
                onPressed: () => context.go('/settings'),
                child: Text('Go settings')),
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
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => context.go('/'), child: Text('Go home')),
            TextButton(
                onPressed: () => context.go('/details'),
                child: Text('Go details')),
          ],
        ),
      ),
    );
  }
}

class OEApp extends StatelessWidget {
  const OEApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Go Router Study App',
      debugShowCheckedModeBanner: true,
      routerConfig: GoRouter(debugLogDiagnostics: true, routes: [
        GoRoute(path: '/', builder: (_, __) => OEHomeScreen(), routes: [
          GoRoute(
              path: 'details',
              builder: (_, __) => OEDetailsScreen(),
              onExit: (context, _) async => await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Confirm'),
                      contentPadding: EdgeInsets.all(32),
                      content: Text('Sure you really want to exit??'),
                      actions: [
                        TextButton(
                            key: Key('no'),
                            onPressed: () => context.pop(false),
                            child: Text('Not really')),
                        TextButton(
                            key: Key('yes'),
                            onPressed: () => context.pop(true),
                            child: Text('Definately!!'))
                      ],
                    ),
                  )),
          GoRoute(path: 'settings', builder: (_, __) => OESettingsScreen())
        ])
      ]),
    );
  }
}
