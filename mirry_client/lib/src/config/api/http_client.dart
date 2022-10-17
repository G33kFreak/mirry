import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mirry_client/src/environment/variables.dart';

class HttpClient {
  const HttpClient();

  Dio _createHttpClient() {
    final dio = Dio(
      BaseOptions(
        baseUrl: EnvironmentVariables.baseUrl,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': EnvironmentVariables.mirrorApiKey,
        },
      ),
    );

    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    return dio;
  }

  Dio get httpClient => _createHttpClient();
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
