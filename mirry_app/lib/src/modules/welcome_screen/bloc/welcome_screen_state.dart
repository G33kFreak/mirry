part of 'welcome_screen_bloc.dart';

@autoequalMixin
class WelcomeScreenState extends Equatable
    with _$WelcomeScreenStateAutoequalMixin {
  final bool hidePassword;
  final String username;
  final String password;
  final LoadingState loadingState;
  final WelcomeScreenError error;

  const WelcomeScreenState({
    this.hidePassword = true,
    this.username = '',
    this.password = '',
    this.loadingState = const IdleState(),
    this.error = WelcomeScreenError.none,
  });

  WelcomeScreenState copyWith({
    bool? hidePassword,
    String? username,
    String? password,
    LoadingState? loadingState,
    WelcomeScreenError? error,
  }) =>
      WelcomeScreenState(
        hidePassword: hidePassword ?? this.hidePassword,
        username: username ?? this.username,
        password: password ?? this.password,
        loadingState: loadingState ?? this.loadingState,
        error: error ?? this.error,
      );
}
