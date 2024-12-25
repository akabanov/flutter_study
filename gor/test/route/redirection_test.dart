import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

var gc = 0;
var mc = 0;
var lc = 0;
var checkingOrder = [];

class RTApp extends StatelessWidget {
  RTApp({super.key});

  final router = GoRouter(
      initialLocation: '/',
      redirect: (_, __) {
        gc++;
        checkingOrder.add('root');
        return null;
      },
      routes: [
        GoRoute(path: '/', builder: (_, __) => const Placeholder(), routes: [
          GoRoute(
              path: 'a',
              builder: (_, __) => const Placeholder(),
              redirect: (_, __) {
                mc++;
                checkingOrder.add('a');
                return null;
              },
              routes: [
                GoRoute(
                  path: 'b',
                  builder: (_, __) => const Placeholder(),
                  redirect: (_, __) {
                    lc++;
                    checkingOrder.add('b');
                    return null;
                  },
                )
              ]),
        ])
      ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

void main() {
  setUp(checkingOrder.clear);

  group('Testing redirection primitives', () {
    testWidgets('Page redirection', (t) async {
      var app = RTApp();
      await t.pumpWidget(app);

      // one global redirect test when app starts
      expect(gc, 1);
      expect(mc, 0);
      expect(lc, 0);

      // redirecting to the current location triggers 'redirect' anyway
      app.router.go('/');
      await t.pumpAndSettle();
      expect(gc, 2);
      expect(mc, 0);
      expect(lc, 0);

      // landing on the page with 'redirect' triggers the redirect
      app.router.go('/a');
      await t.pumpAndSettle();
      expect(gc, 3);
      expect(mc, 1);
      expect(lc, 0);

      // landing on the page triggers all parent redirect checks
      app.router.go('/a/b');
      await t.pumpAndSettle();
      expect(gc, 4);
      expect(mc, 2);
      expect(lc, 1);

      // leaving the page doesn't trigger it's 'redirect' checks
      app.router.go('/');
      await t.pumpAndSettle();
      expect(gc, 5);
      expect(mc, 2);
      expect(lc, 1);
    });

    testWidgets('Redirect checks go from root to leafs', (t) async {
      var app = RTApp();
      await t.pumpWidget(app);
      checkingOrder.clear();
      app.router.go('/a/b');
      expect(checkingOrder, ['root', 'a', 'b']);
    });
  });
}
