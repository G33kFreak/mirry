import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mirry/src/config/api/m_interceptor.dart';
import 'package:mirry/src/environment/variables.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';

class ApiClient {
  final ITokensRepository _tokensRepository;

  const ApiClient({
    required ITokensRepository tokensRepository,
  }) : _tokensRepository = tokensRepository;

  Dio _createApiClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentVariables.baseUrl,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ),
    );

    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    return dio;
  }

  Dio get httpClient => _createApiClient();

  Dio get authenticatedHttpClient {
    final dio = _createApiClient();
    dio.interceptors.add(MInterceptor(
      tokensRepository: _tokensRepository,
    ));

    return dio;
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
