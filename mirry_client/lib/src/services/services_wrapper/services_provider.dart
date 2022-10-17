import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/api/http_client.dart';
import 'package:mirry_client/src/config/socket/mirry_socket.dart';
import 'package:mirry_client/src/services/user_recognition/bloc/user_recognition_bloc.dart';

class ServicesProvider extends StatelessWidget {
  final Widget child;

  const ServicesProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<HttpClient>(
          create: (context) => const HttpClient(),
        ),
        RepositoryProvider<MirrySocket>(
          create: (context) => MirrySocket(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserRecognitionBloc>(
            create: (context) => UserRecognitionBloc(
              mirrySocket: context.read<MirrySocket>(),
            ),
            lazy: false,
          ),
        ],
        child: child,
      ),
    );
  }
}
