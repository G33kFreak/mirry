import 'package:mirry_client/src/repositories/todo_repository/src/models/todo_list_response.dart';

abstract class ITodoRepository {
  Future<TodoListResponse> getTodoList({
    required String user,
    int limit = 5,
    int page = 0,
  });
}
