part of 'welcome_screen_bloc.dart';

@autoequalMixin
class WelcomeScreenState extends Equatable
    with _$WelcomeScreenStateAutoequalMixin {
  final bool hidePassword;
  final String username;
  final String password;
  final LoadingState loadingState;
  final WelcomeScreenError error;
  final WelcomeScreenMode screenMode;
  final File? photo;

  const WelcomeScreenState({
    this.hidePassword = true,
    this.username = '',
    this.password = '',
    this.loadingState = const IdleState(),
    this.error = WelcomeScreenError.none,
    this.screenMode = WelcomeScreenMode.signin,
    this.photo,
  });

  WelcomeScreenState copyWith({
    bool? hidePassword,
    String? username,
    String? password,
    LoadingState? loadingState,
    WelcomeScreenError? error,
    WelcomeScreenMode? screenMode,
    File? photo,
  }) =>
      WelcomeScreenState(
        hidePassword: hidePassword ?? this.hidePassword,
        username: username ?? this.username,
        password: password ?? this.password,
        loadingState: loadingState ?? this.loadingState,
        error: error ?? this.error,
        screenMode: screenMode ?? this.screenMode,
        photo: photo ?? this.photo,
      );
}
