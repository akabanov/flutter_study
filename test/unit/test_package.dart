import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  group('checking setUp and tearDown', () {
    late HttpServer server;
    late Uri uri;

    setUp(() async {
      server = await HttpServer.bind('localhost', 0);
       server.forEach((HttpRequest request) {
        request.response.write('hello');
        request.response.close();
      });
      uri = Uri.parse("http://${server.address.host}:${server.port}");
    });

    tearDown(() async {
      await server.close(force: true);
    });

    test('test default server response', () async {
      var client = Client();
      var response = await client.get(uri);
      expect(response.body, equals('hello'));
    });
  });
}
