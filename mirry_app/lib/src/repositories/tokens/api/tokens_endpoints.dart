import 'package:dio/dio.dart';

typedef LogIn = Future<Response> Function(
  Dio, {
  required String username,
  required String password,
});
typedef RefreshTokens = Future<Response> Function(
  Dio, {
  required String refreshToken,
});

final LogIn logIn = (
  Dio httpClient, {
  required String username,
  required String password,
}) =>
    httpClient.post('/auth/login', data: {
      'username': username,
      'password': password,
    });

final RefreshTokens refreshTokens = (
  Dio httpClient, {
  required String refreshToken,
}) =>
    httpClient.post(
      '/auth/refresh-tokens',
      data: {'refreshToken': refreshToken},
    );
