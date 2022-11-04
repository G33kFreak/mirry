import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/routes.dart';
import 'package:mirry/src/repositories/tokens/models/authentication_status.dart';
import 'package:mirry/src/services/authentication/bloc/authentication_bloc.dart';

BlocListener authenticationWrapper({required AppRouter router}) {
  return BlocListener<AuthenticationBloc, AuthenticationState>(
    listener: (context, state) {
      switch (state.status) {
        case AuthenticationStatus.authenticated:
          router.replaceNamed(Routes.main.generatePath());
          break;
        case AuthenticationStatus.unauthenticated:
          router.replaceNamed(Routes.welcome.generatePath());
          break;
        default:
          break;
      }
    },
  );
}
