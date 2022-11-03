import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/api/api_client.dart';
import 'package:mirry/src/modules/welcome_screen/bloc/welcome_screen_bloc.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';

class WelcomeScreenBlocProvider extends StatelessWidget {
  final Widget child;

  const WelcomeScreenBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeScreenBloc(
        tokensRepository: context.read<ITokensRepository>(),
        httpClient: context.read<ApiClient>().httpClient,
      ),
      child: child,
    );
  }
}
