import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/socket/mirry_socket.dart';
import 'package:mirry_client/src/config/socket/mirry_socket_actions.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/models/todo_item.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/models/todo_list_response.dart';
import 'package:mirry_client/src/repositories/todo_repository/todo_repository.dart';

part 'todo_module_event.dart';
part 'todo_module_state.dart';
part 'todo_module_bloc.g.dart';

class TodoModuleBloc extends Bloc<TodoModuleEvent, TodoModuleState> {
  final ITodoRepository _todoRepository;
  final MirrySocket _mirrySocket;

  TodoModuleBloc({
    required ITodoRepository todoRepository,
    required MirrySocket mirrySocket,
  })  : _todoRepository = todoRepository,
        _mirrySocket = mirrySocket,
        super(const TodoModuleState()) {
    _setupSocketsActions();
    on<InitTodoModule>(_onInitTodoModule);
    on<TodoItemChanged>(_onTodoItemChanged);
  }

  void _setupSocketsActions() {
    _mirrySocket.socketChannel.on(
      MirrySocketActions.todoItemChanged.value,
      _onItemChangedSocketAction,
    );
  }

  void _onItemChangedSocketAction(dynamic data) {
    final todoItem = TodoItem.fromJson(data);
    add(TodoItemChanged(newTodoItem: todoItem));
  }

  void _onTodoItemChanged(
    TodoItemChanged event,
    Emitter<TodoModuleState> emit,
  ) {
    final currentList = List<TodoItem>.from(state.todoItems);
    final changedItemIndex = currentList.indexWhere(
      (item) => item.id == event.newTodoItem.id,
    );

    if (changedItemIndex != -1) {
      currentList.replaceRange(
        changedItemIndex,
        changedItemIndex + 1,
        [event.newTodoItem],
      );
      emit(state.copyWith(todoItems: currentList));
    }
  }

  Future<void> _onInitTodoModule(
    InitTodoModule event,
    Emitter<TodoModuleState> emit,
  ) async {
    try {
      final listResponse = await _todoRepository.getTodoList(
        user: event.userId,
      );

      emit(state.copyWith(
        todoListResponse: listResponse,
        todoItems: listResponse.items,
      ));
      //TODO: add error handling
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> close() {
    _mirrySocket.socketChannel.off(MirrySocketActions.todoItemChanged.value);
    return super.close();
  }
}
