import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/repositories/tokens/models/authentication_status.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.g.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ITokensRepository _tokensRepository;

  late StreamSubscription<AuthenticationStatus> _authenticationSubscription;

  AuthenticationBloc({
    required ITokensRepository tokensRepository,
  })  : _tokensRepository = tokensRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationSubscription = _tokensRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );

    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
  }

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
      case AuthenticationStatus.authenticated:
        return emit(const AuthenticationState.authenticated());
      case AuthenticationStatus.unauthenticated:
        {
          final tokens = await _tokensRepository.getTokens();
          if (tokens != null) {
            return emit(const AuthenticationState.authenticated());
          } else {
            await Future.delayed(const Duration(seconds: 3));
            return emit(const AuthenticationState.unauthenticated());
          }
        }
    }
  }

  @override
  Future<void> close() {
    _authenticationSubscription.cancel();
    _tokensRepository.dispose();
    return super.close();
  }
}
