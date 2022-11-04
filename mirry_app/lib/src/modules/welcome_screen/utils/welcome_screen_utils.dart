import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum WelcomeScreenMode {
  signin,
  signup,
}

enum WelcomeScreenError {
  none,
  wrongData,
  serverError,
  unknownError,
  signUpError,
}

class WelcomeScreenBlocException with EquatableMixin implements Exception {
  final String cause;
  const WelcomeScreenBlocException(this.cause);

  @override
  String toString() => '$runtimeType $cause';

  @override
  List<Object?> get props => [cause];
}

extension StringValuesForWelcomeErrors on WelcomeScreenError {
  String get text {
    switch (this) {
      case WelcomeScreenError.none:
        return 'No error';
      case WelcomeScreenError.wrongData:
        return 'Invalid username or password';
      case WelcomeScreenError.serverError:
        return 'Server error';
      case WelcomeScreenError.unknownError:
        return 'Unknown error';
      case WelcomeScreenError.signUpError:
        return 'Sign up error';
    }
  }

  String localizedText(AppLocalizations appLocalizations) {
    switch (this) {
      case WelcomeScreenError.none:
        return appLocalizations.noError;
      case WelcomeScreenError.wrongData:
        return appLocalizations.wrongUsernameOrPassword;
      case WelcomeScreenError.serverError:
        return appLocalizations.serverError;
      case WelcomeScreenError.unknownError:
        return appLocalizations.unknownError;
      case WelcomeScreenError.signUpError:
        return appLocalizations.wrongSignUpData;
    }
  }
}
