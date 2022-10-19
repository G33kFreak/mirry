part of 'todo_module_bloc.dart';

abstract class TodoModuleEvent extends Equatable {
  const TodoModuleEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitTodoModule extends TodoModuleEvent
    with _$InitTodoModuleAutoequalMixin {
  final String userId;

  const InitTodoModule({required this.userId});
}

@autoequalMixin
class TodoItemChanged extends TodoModuleEvent
    with _$TodoItemChangedAutoequalMixin {
  final TodoItem newTodoItem;

  const TodoItemChanged({required this.newTodoItem});
}

@autoequalMixin
class TodoItemAdded extends TodoModuleEvent with _$TodoItemAddedAutoequalMixin {
  final TodoItem newTodoItem;

  const TodoItemAdded({required this.newTodoItem});
}

@autoequalMixin
class TodoItemDeleted extends TodoModuleEvent
    with _$TodoItemDeletedAutoequalMixin {
  final String itemId;

  const TodoItemDeleted({required this.itemId});
}
