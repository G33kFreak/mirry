import 'package:json_annotation/json_annotation.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/models/todo_item.dart';

part 'todo_list_response.g.dart';

@JsonSerializable()
class TodoListResponse {
  final int page;
  final int lastPage;
  final List<TodoItem> items;

  const TodoListResponse({
    required this.page,
    required this.lastPage,
    required this.items,
  });

  factory TodoListResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TodoListResponseToJson(this);
}
