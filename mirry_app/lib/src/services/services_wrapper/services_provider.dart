import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry/src/config/api/api_client.dart';
import 'package:mirry/src/repositories/mirry_connection/mirry_connection_repository.dart';
import 'package:mirry/src/repositories/settings/api/settings_endpoints.dart';
import 'package:mirry/src/repositories/settings/settings_repository.dart';
import 'package:mirry/src/repositories/tokens/api/tokens_endpoints.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';
import 'package:mirry/src/services/authentication/bloc/authentication_bloc.dart';
import 'package:mirry/src/services/mirry_connection/bloc/mirry_connection_service_bloc.dart';
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
        RepositoryProvider<IMirryConnectionRepository>(
          create: (context) => MirryConnectionRepository(),
        ),
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
            mirryConnectionRepository:
                context.read<IMirryConnectionRepository>(),
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
            create: (context) {
              final bloc = MirryConnectionServiceBloc(
                mirryConnectionRepository:
                    context.read<IMirryConnectionRepository>(),
              );

              bloc.add(const InitMirryConnectionService());

              return bloc;
            },
            lazy: false,
          ),
          BlocProvider(
            create: (context) => SettingsBloc(
              settingsRepository: context.read<ISettingsRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AuthenticationBloc(
              tokensRepository: context.read<ITokensRepository>(),
              settingsBloc: context.read<SettingsBloc>(),
              mirryConnectionServiceBloc:
                  context.read<MirryConnectionServiceBloc>(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
