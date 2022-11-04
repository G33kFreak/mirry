import 'package:dio/dio.dart';

typedef GetSettings = Future<Response> Function(Dio);

final GetSettings getSettings = (Dio httpClient) => httpClient.get('/settings');
