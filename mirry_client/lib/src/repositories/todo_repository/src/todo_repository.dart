import 'package:dio/dio.dart';
import 'package:mirry_client/src/config/api/exceptions.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/api/todo_endpoints.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/models/todo_list_response.dart';
import 'package:mirry_client/src/repositories/todo_repository/todo_repository.dart';

class TodoRepository implements ITodoRepository {
  final Dio _httpClient;
  final GetTodoList _getTodoList;

  const TodoRepository({
    required Dio httpClient,
    required GetTodoList getTodoList,
  })  : _httpClient = httpClient,
        _getTodoList = getTodoList;

  @override
  Future<TodoListResponse> getTodoList({
    required String user,
    int limit = 5,
    int page = 0,
  }) async {
    final response = await _getTodoList(_httpClient, limit, page, user);
    try {
      return TodoListResponse.fromJson(response.data);
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
