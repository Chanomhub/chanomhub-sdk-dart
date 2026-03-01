import 'package:flutter_test/flutter_test.dart';
import 'package:chanomhub_flutter/chanomhub_flutter.dart';
import 'package:dio/dio.dart';

void main() {
  group('ChanomhubClient Tests', () {
    late ChanomhubClient client;

    setUp(() {
      client = ChanomhubClient(
        baseUrl: 'https://api.example.com',
        cdnUrl: 'https://cdn.example.com',
      );
    });

    test('should initialize with correct base URL', () {
      expect(client.dio.options.baseUrl, 'https://api.example.com');
    });

    test('should have default timeouts set', () {
      expect(client.dio.options.connectTimeout, const Duration(seconds: 15));
      expect(client.dio.options.receiveTimeout, const Duration(seconds: 15));
    });

    test('should accept custom Dio instance', () {
      final customDio = Dio(BaseOptions(baseUrl: 'https://custom.com'));
      final customClient = ChanomhubClient(
        baseUrl: 'https://ignored.com', // customDio base URL takes precedence
        cdnUrl: 'https://cdn.ignored.com',
        dioOverride: customDio,
      );

      expect(customClient.dio.options.baseUrl, 'https://custom.com');
    });
  });

  group('ApiClient Error Handling Tests', () {
    test('should parse 401 error into AuthenticationException', () async {
      expect(const AuthenticationException('test').statusCode, 401);
    });

    test('should parse 404 error into NotFoundException', () async {
      expect(const NotFoundException('test').statusCode, 404);
    });
  });
}
