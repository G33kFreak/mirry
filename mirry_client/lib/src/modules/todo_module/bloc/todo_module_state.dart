part of 'todo_module_bloc.dart';

@autoequalMixin
class TodoModuleState extends Equatable with _$TodoModuleStateAutoequalMixin {
  final TodoListResponse? todoListResponse;
  final List<TodoItem> todoItems;

  const TodoModuleState({
    this.todoListResponse,
    this.todoItems = const [],
  });

  TodoModuleState copyWith({
    TodoListResponse? todoListResponse,
    List<TodoItem>? todoItems,
  }) =>
      TodoModuleState(
        todoListResponse: todoListResponse,
        todoItems: todoItems ?? this.todoItems,
      );
}
