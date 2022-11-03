part of '../tokens_repository.dart';

abstract class ITokensRepository {
  String get tokensKey;

  Future<void> saveToken(JwtTokens tokens);

  Future<JwtTokens?> getTokens();

  Future<void> deleteTokens();

  Stream<AuthenticationStatus> get status;

  StreamController<AuthenticationStatus>? controller;

  Future<JwtTokens?> performRefreshTokens(
    Dio httpClient, {
    required String refreshToken,
  });
}
