import 'dart:async';

import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/repositories/tokens/models/authentication_status.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';
import 'package:mirry/src/services/mirry_connection/bloc/mirry_connection_service_bloc.dart';
import 'package:mirry/src/services/settings/bloc/settings_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.g.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final ITokensRepository _tokensRepository;
  final SettingsBloc _settingsBloc;
  final MirryConnectionServiceBloc _mirryConnectionServiceBloc;

  late StreamSubscription<AuthenticationStatus> _authenticationSubscription;

  AuthenticationBloc({
    required ITokensRepository tokensRepository,
    required SettingsBloc settingsBloc,
    required MirryConnectionServiceBloc mirryConnectionServiceBloc,
  })  : _tokensRepository = tokensRepository,
        _settingsBloc = settingsBloc,
        _mirryConnectionServiceBloc = mirryConnectionServiceBloc,
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
        {
          _settingsBloc.add(const InitSettings());
          return emit(const AuthenticationState.authenticated());
        }
      case AuthenticationStatus.unauthenticated:
        {
          final tokens = await _tokensRepository.getTokens();
          if (tokens != null) {
            _settingsBloc.add(const InitSettings());
            return emit(const AuthenticationState.authenticated());
          } else {
            await Future.doWhile(() async {
              await Future.delayed(const Duration(milliseconds: 500));
              return _mirryConnectionServiceBloc.state is! MirryConnectedState;
            });
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
