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
