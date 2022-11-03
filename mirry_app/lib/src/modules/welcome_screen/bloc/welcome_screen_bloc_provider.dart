import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/api/api_client.dart';
import 'package:mirry/src/modules/welcome_screen/bloc/welcome_screen_bloc.dart';
import 'package:mirry/src/modules/welcome_screen/utils/welcome_screen_utils.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';
import 'package:mirry/src/services/error_manager/error_manager.dart';
import 'package:mirry/src/widgets/error_snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      child: ErrorManager<WelcomeScreenBloc, WelcomeScreenState,
          WelcomeScreenError>(
        onError: (error) => showErrorSnackbar(
          context,
          errorText: error.localizedText(AppLocalizations.of(context)!),
        ),
        child: child,
      ),
    );
  }
}
