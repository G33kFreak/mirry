part of 'welcome_screen_bloc.dart';

abstract class WelcomeScreenEvent extends Equatable {
  const WelcomeScreenEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class ChangeUsername extends WelcomeScreenEvent
    with _$ChangeUsernameAutoequalMixin {
  final String newUsername;

  const ChangeUsername(this.newUsername);
}

@autoequalMixin
class ChangePassword extends WelcomeScreenEvent
    with _$ChangePasswordAutoequalMixin {
  final String newPassword;

  const ChangePassword(this.newPassword);
}

@autoequalMixin
class TurnPasswordVisibility extends WelcomeScreenEvent
    with _$TurnPasswordVisibilityAutoequalMixin {
  const TurnPasswordVisibility();
}

@autoequalMixin
class LoadingStateChanged extends WelcomeScreenEvent
    with _$LoadingStateChangedAutoequalMixin {
  final LoadingState loadingState;

  const LoadingStateChanged({required this.loadingState});
}

@autoequalMixin
class SignInPressed extends WelcomeScreenEvent
    with _$SignInPressedAutoequalMixin {
  const SignInPressed();
}

@autoequalMixin
class HideError extends WelcomeScreenEvent with _$HideErrorAutoequalMixin {
  const HideError();
}

@autoequalMixin
class ChangeScreenMode extends WelcomeScreenEvent
    with _$ChangeScreenModeAutoequalMixin {
  const ChangeScreenMode();
}

@autoequalMixin
class UploadPhoto extends WelcomeScreenEvent with _$UploadPhotoAutoequalMixin {
  final File file;

  const UploadPhoto({required this.file});
}

@autoequalMixin
class SignUpPressed extends WelcomeScreenEvent
    with _$SignUpPressedAutoequalMixin {
  const SignUpPressed();
}
