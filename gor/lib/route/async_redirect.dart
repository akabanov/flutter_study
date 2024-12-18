import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ------------------

class ARApp extends StatelessWidget {
  ARApp({super.key});

  static const title = 'Async Redirect Study';

  final _router = GoRouter(
      restorationScopeId: 'router',
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => ARHomeScreen()),
        GoRoute(path: '/login', builder: (_, __) => ARLoginScreen())
      ],
      redirect: (context, state) {
        var streamAuth = StreamAuthScope.of(context);
        bool atLogin = state.matchedLocation == '/login';
        bool signedIn = streamAuth.user != null;
        if (!signedIn && !atLogin) {
          return '/login';
        }
        if (signedIn && atLogin) {
          return '/';
        }

        return null;
      });

  @override
  Widget build(BuildContext context) {
    return StreamAuthScope(
        child: MaterialApp.router(
      title: title,
      restorationScopeId: 'app',
      routerConfig: _router,
    ));
  }
}

// ------------

class ARHomeScreen extends StatelessWidget {
  const ARHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var streamAuth = StreamAuthScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Classified'),
        actions: [
          IconButton(onPressed: streamAuth.signOut, icon: Icon(Icons.logout))
        ],
      ),
      body:
          Center(child: Text('Well, hello ${streamAuth.user}. And good-bye!')),
    );
  }
}

// --------------

class ARLoginScreen extends StatefulWidget {
  const ARLoginScreen({super.key});

  @override
  State<ARLoginScreen> createState() => _ARLoginScreenState();
}

class _ARLoginScreenState extends State<ARLoginScreen>
    with TickerProviderStateMixin {
  bool _authStarted = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addListener(() => setState(() {}))
          ..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var streamAuth = StreamAuthScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
          child: _authStarted
              ? CircularProgressIndicator(
                  value: _animationController.value,
                )
              : ElevatedButton(
                  onPressed: () async {
                    _authStarted = true;
                    await streamAuth.login('Alex');
                  },
                  child: Text('Login'),
                )),
    );
  }
}

// -----------------

class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  StreamAuthScope({
    super.key,
    required super.child,
  }) : super(notifier: StreamAuthNotifier());

  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }

  String? get user => notifier!.streamAuth.user;

  @override
  bool updateShouldNotify(StreamAuthScope oldWidget) {
    return user != oldWidget.user;
  }
}

class StreamAuthNotifier extends ChangeNotifier {
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.stream.listen((_) => notifyListeners());
  }

  final StreamAuth streamAuth;
}

class StreamAuth {
  StreamAuth([this.sessionDuration = 5])
      : _authStreamController = StreamController.broadcast() {
    _authStreamController.stream.listen((user) => _user = user);
  }

  Stream<String?> get stream => _authStreamController.stream;
  final StreamController<String?> _authStreamController;

  String? get user => _user;
  String? _user;

  final int sessionDuration;
  Timer? _logoutTimer;

  Future<void> login(String user) => Future.delayed(Duration(seconds: 1), () {
        _logoutTimer?.cancel();
        _authStreamController.add(user);
        _logoutTimer = Timer(Duration(seconds: sessionDuration), signOut);
      });

  void signOut() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
    _authStreamController.add(null);
  }

  void dispose() {
    _logoutTimer?.cancel();
    _authStreamController.close();
  }
}
