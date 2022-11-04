part of '../tokens_repository.dart';

class TokensRepository
    with IHiveRepository<JwtTokens>
    implements ITokensRepository {
  final RefreshTokens _refreshTokens;
  final LogIn _logIn;
  final SignUp _signUp;

  TokensRepository({
    required RefreshTokens refreshTokens,
    required LogIn logIn,
    required SignUp signUp,
  })  : _refreshTokens = refreshTokens,
        _logIn = logIn,
        _signUp = signUp;

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

  @override
  Future<JwtTokens> performLogIn(
    Dio httpClient, {
    required String username,
    required String password,
  }) async {
    final response = await _logIn(
      httpClient,
      username: username,
      password: password,
    );

    try {
      final tokens = JwtTokens.fromJson(response.data);
      return tokens;
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }

  @override
  Future<void> performSignUp(
    Dio httpClient, {
    required String username,
    required String password,
    required File photo,
  }) async {
    final fileName = photo.path.split('/').last;

    final formData = FormData.fromMap({
      'photo': await MultipartFile.fromFile(photo.path, filename: fileName),
      'username': username,
      'password': password,
    });

    await _signUp(httpClient, data: formData);
  }

  @override
  void dispose() => controller!.close();
}
