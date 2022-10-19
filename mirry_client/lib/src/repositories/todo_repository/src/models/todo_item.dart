import 'package:json_annotation/json_annotation.dart';

part 'todo_item.g.dart';

@JsonSerializable()
class TodoItem {
  final String title;
  final String description;
  final String id;
  final bool isDone;

  const TodoItem({
    required this.title,
    required this.description,
    required this.id,
    required this.isDone,
  });

  factory TodoItem.fromJson(Map<String, dynamic> json) =>
      _$TodoItemFromJson(json);

  Map<String, dynamic> toJson() => _$TodoItemToJson(this);
}
