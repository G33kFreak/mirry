import 'package:dio/dio.dart';

typedef RefreshTokens = Future<Response> Function(
  Dio, {
  required String refreshToken,
});

final RefreshTokens refreshTokens = (
  Dio httpClient, {
  required String refreshToken,
}) =>
    httpClient.post(
      '/auth/refresh-tokens',
      data: {
        'refreshToken': refreshToken,
      },
    );
