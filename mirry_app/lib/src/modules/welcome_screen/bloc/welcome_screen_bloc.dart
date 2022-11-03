import 'package:autoequal/autoequal.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';
import 'package:mirry/src/utils/loading_state.dart';

part 'welcome_screen_event.dart';
part 'welcome_screen_state.dart';
part 'welcome_screen_bloc.g.dart';

class WelcomeScreenBloc extends Bloc<WelcomeScreenEvent, WelcomeScreenState> {
  final ITokensRepository _tokensRepository;
  final Dio _httpClient;

  WelcomeScreenBloc({
    required ITokensRepository tokensRepository,
    required Dio httpClient,
  })  : _tokensRepository = tokensRepository,
        _httpClient = httpClient,
        super(const WelcomeScreenState()) {
    on<ChangeUsername>(_onChangeUsername);
    on<ChangePassword>(_onChangePassword);
    on<TurnPasswordVisibility>(_onTurnPasswordVisibility);
    on<LoadingStateChanged>(_onLoadingStateChanged);
    on<SignInPressed>(_onSignInPressed);
  }

  void _onChangeUsername(
    ChangeUsername event,
    Emitter<WelcomeScreenState> emit,
  ) {
    emit(state.copyWith(username: event.newUsername));
  }

  void _onChangePassword(
    ChangePassword event,
    Emitter<WelcomeScreenState> emit,
  ) {
    emit(state.copyWith(password: event.newPassword));
  }

  void _onTurnPasswordVisibility(
    TurnPasswordVisibility event,
    Emitter<WelcomeScreenState> emit,
  ) {
    emit(state.copyWith(hidePassword: !state.hidePassword));
  }

  void _onLoadingStateChanged(
    LoadingStateChanged event,
    Emitter<WelcomeScreenState> emit,
  ) {
    emit(state.copyWith(loadingState: event.loadingState));
  }

  Future<void> _onSignInPressed(
    SignInPressed event,
    Emitter<WelcomeScreenState> emit,
  ) async {
    emit(state.copyWith(loadingState: const InProgressState()));

    try {
      final tokens = await _tokensRepository.performLogIn(
        _httpClient,
        username: state.username,
        password: state.password,
      );
      await _tokensRepository.saveToken(tokens);
    } catch (e) {
      //
    }
  }
}
