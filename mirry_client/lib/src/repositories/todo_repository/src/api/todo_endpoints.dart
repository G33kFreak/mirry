import 'package:dio/dio.dart';

typedef GetTodoList = Future<Response> Function(Dio, int, int, String);

final GetTodoList getTodoList = (
  Dio httpClient,
  int limit,
  int page,
  String user,
) =>
    httpClient.get('/todo/list', queryParameters: {
      'page': page,
      'limit': limit,
      'user': user,
    });
