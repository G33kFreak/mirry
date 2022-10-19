part of 'todo_module_bloc.dart';

@autoequalMixin
class TodoModuleState extends Equatable with _$TodoModuleStateAutoequalMixin {
  final TodoListResponse? todoListResponse;
  final List<TodoItem> todoItems;
  final String userId;

  const TodoModuleState({
    this.todoListResponse,
    this.todoItems = const [],
    this.userId = '',
  });

  TodoModuleState copyWith({
    TodoListResponse? todoListResponse,
    List<TodoItem>? todoItems,
    String? userId,
  }) =>
      TodoModuleState(
        todoListResponse: todoListResponse ?? this.todoListResponse,
        todoItems: todoItems ?? this.todoItems,
        userId: userId ?? this.userId,
      );
}
