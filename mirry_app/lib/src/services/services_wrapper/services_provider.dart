import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/api/api_client.dart';
import 'package:mirry/src/repositories/settings/api/settings_endpoints.dart';
import 'package:mirry/src/repositories/settings/settings_repository.dart';
import 'package:mirry/src/repositories/tokens/api/tokens_endpoints.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';
import 'package:mirry/src/services/authentication/bloc/authentication_bloc.dart';
import 'package:mirry/src/services/settings/bloc/settings_bloc.dart';

class ServicesProvider extends StatelessWidget {
  final Widget child;

  const ServicesProvider({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ITokensRepository>(
          create: (context) => TokensRepository(
            refreshTokens: refreshTokens,
            logIn: logIn,
            signUp: signUp,
          ),
        ),
        RepositoryProvider<ApiClient>(
          create: (context) => ApiClient(
            tokensRepository: context.read<ITokensRepository>(),
          ),
        ),
        RepositoryProvider<ISettingsRepository>(
          create: (context) => SettingsRepository(
            authHttpClient: context.read<ApiClient>().authenticatedHttpClient,
            getSettings: getSettings,
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsBloc(
              settingsRepository: context.read<ISettingsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(
              tokensRepository: context.read<ITokensRepository>(),
              settingsBloc: context.read<SettingsBloc>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
