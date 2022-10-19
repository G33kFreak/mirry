import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/api/http_client.dart';
import 'package:mirry_client/src/config/socket/mirry_socket.dart';
import 'package:mirry_client/src/modules/todo_module/bloc/todo_module_bloc.dart';
import 'package:mirry_client/src/repositories/todo_repository/src/api/todo_endpoints.dart';
import 'package:mirry_client/src/repositories/todo_repository/todo_repository.dart';
import 'package:mirry_client/src/services/user_recognition/bloc/user_recognition_bloc.dart';

class TodoModuleBlocProvider extends StatelessWidget {
  final Widget child;

  const TodoModuleBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ITodoRepository>(
      create: (context) => TodoRepository(
        httpClient: context.read<HttpClient>().httpClient,
        getTodoList: getTodoList,
      ),
      child: BlocProvider(
        create: (context) {
          final bloc = TodoModuleBloc(
            mirrySocket: context.read<MirrySocket>(),
            todoRepository: context.read<ITodoRepository>(),
          );
          final userId =
              context.read<UserRecognitionBloc>().state.currentUser!.id;
          bloc.add(InitTodoModule(userId: userId));

          return bloc;
        },
        child: child,
      ),
    );
  }
}
