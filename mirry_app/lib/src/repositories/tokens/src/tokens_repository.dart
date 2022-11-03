part of '../tokens_repository.dart';

class TokensRepository
    with IHiveRepository<JwtTokens>
    implements ITokensRepository {
  final RefreshTokens _refreshTokens;

  TokensRepository({required RefreshTokens refreshTokens})
      : _refreshTokens = refreshTokens;

  @override
  StreamController<AuthenticationStatus>? controller =
      StreamController<AuthenticationStatus>.broadcast();

  @override
  String get boxKey => 'tokensBoxKey';

  @override
  String get tokensKey => 'tokensKey';

  @override
  Future<void> deleteTokens() async {
    (await box).delete(tokensKey);
    controller!.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Future<JwtTokens?> getTokens() async {
    return (await box).get(tokensKey);
  }

  @override
  Future<void> saveToken(JwtTokens tokens) async {
    (await box).put(tokensKey, tokens);
    controller!.add(AuthenticationStatus.authenticated);
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    final tokens = await getTokens();
    if (tokens != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* controller!.stream;
  }

  void dispose() => controller!.close();

  @override
  Future<JwtTokens?> performRefreshTokens(
    Dio httpClient, {
    required String refreshToken,
  }) async {
    final response = await _refreshTokens(
      httpClient,
      refreshToken: refreshToken,
    );

    try {
      final tokens = JwtTokens.fromJson(response.data);
      await saveToken(tokens);
      return tokens;
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
