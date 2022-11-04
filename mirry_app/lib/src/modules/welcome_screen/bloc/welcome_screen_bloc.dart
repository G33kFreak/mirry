import 'dart:io';

import 'package:autoequal/autoequal.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:mirry/src/modules/welcome_screen/utils/welcome_screen_utils.dart';
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
    on<HideError>(_onHideError);
    on<ChangeScreenMode>(_onChangeScreenMode);
    on<UploadPhoto>(_onUploadPhoto);
    on<SignUpPressed>(_onSignUpPressed);
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
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(loadingState: const SuccessState()));
    } on DioError catch (e) {
      if (e.response?.statusCode == StatusCode.UNAUTHORIZED) {
        throw _emitErrorState(WelcomeScreenError.wrongData, emit);
      } else {
        throw _emitErrorState(WelcomeScreenError.serverError, emit, e.error);
      }
    } catch (e) {
      throw _emitErrorState(WelcomeScreenError.unknownError, emit, e);
    } finally {
      if (state.error != WelcomeScreenError.none) {
        add(const HideError());
      }
    }
  }

  void _onHideError(
    HideError event,
    Emitter<WelcomeScreenState> emit,
  ) {
    emit(state.copyWith(
      error: WelcomeScreenError.none,
      loadingState: const IdleState(),
    ));
  }

  void _onChangeScreenMode(
    ChangeScreenMode event,
    Emitter<WelcomeScreenState> emit,
  ) {
    final newMode = state.screenMode == WelcomeScreenMode.signin
        ? WelcomeScreenMode.signup
        : WelcomeScreenMode.signin;
    emit(state.copyWith(screenMode: newMode));
  }

  void _onUploadPhoto(
    UploadPhoto event,
    Emitter<WelcomeScreenState> emit,
  ) {
    emit(state.copyWith(photo: event.file));
  }

  Future<void> _onSignUpPressed(
    SignUpPressed event,
    Emitter<WelcomeScreenState> emit,
  ) async {
    emit(state.copyWith(loadingState: const InProgressState()));

    try {
      await _tokensRepository.performSignUp(
        _httpClient,
        username: state.username,
        password: state.password,
        photo: state.photo!,
      );
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(
        loadingState: const SuccessState(),
        screenMode: WelcomeScreenMode.signin,
      ));
    } on DioError catch (e) {
      throw _emitErrorState(WelcomeScreenError.signUpError, emit, e.error);
    } catch (e) {
      throw _emitErrorState(WelcomeScreenError.unknownError, emit, e);
    }
  }

  WelcomeScreenBlocException _emitErrorState(
    WelcomeScreenError error,
    Emitter<WelcomeScreenState> emit, [
    dynamic extra,
  ]) {
    emit(state.copyWith(
      error: error,
      loadingState: const FailedState(),
    ));

    final errorText = extra == null ? error.text : '${error.text} $extra';
    return WelcomeScreenBlocException(errorText);
  }
}
