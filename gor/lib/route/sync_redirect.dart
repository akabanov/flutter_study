import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SRAuthState extends ChangeNotifier {
  String get currentUser => _user;
  String _user = '';

  bool get isLoggedIn => _user.isNotEmpty;

  void login(String user) {
    _user = user;
    notifyListeners();
  }

  void logout() {
    _user = '';
    notifyListeners();
  }
}

class SRApp extends StatelessWidget {
  SRApp({super.key});

  static const appTitle = 'Go Redirect Study';

  final _authState = SRAuthState();

  late final _router = GoRouter(
    restorationScopeId: 'router',
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const SRHomeScreen(),
      ),
      GoRoute(path: '/login', builder: (_, __) => const SRLoginScreen()),
    ],
    redirect: (context, state) {
      var matchedLocation = state.matchedLocation;
      if (matchedLocation != '/' && _authState.isLoggedIn) {
        return '/';
      }
      if (matchedLocation != '/logout' && !_authState.isLoggedIn) {
        return '/login';
      }
      return null;
    },
    refreshListenable: _authState,
  );

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
      value: _authState,
      child: MaterialApp.router(
        restorationScopeId: 'app',
        routerConfig: _router,
        title: appTitle,
      ));
}

class SRHomeScreen extends StatelessWidget {
  const SRHomeScreen() : super(key: const Key('home-screen'));

  @override
  Widget build(BuildContext context) {
    var authState = context.read<SRAuthState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(SRApp.appTitle),
        actions: [
          IconButton(
            key: const Key('logout-btn'),
            onPressed: authState.logout,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          )
        ],
      ),
      body: Center(
        child: Text(
          'Hi, ${authState.currentUser}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class SRLoginScreen extends StatelessWidget {
  const SRLoginScreen() : super(key: const Key('login-screen'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SRApp.appTitle),
      ),
      body: Center(
        child: ElevatedButton(
            key: const Key('login-btn'),
            onPressed: () => context.read<SRAuthState>().login('Alex'),
            child: const Text('Login')),
      ),
    );
  }
}
