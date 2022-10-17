import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/config/api/http_client.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/api/weather_endpoints.dart';
import 'package:mirry_client/src/repositories/weather_repository/weather_repository.dart';

class WeatherModuleBlocProvider extends StatelessWidget {
  final Widget child;

  const WeatherModuleBlocProvider({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        httpClient: context.read<HttpClient>().httpClient,
        getWeather: getWeather,
      ),
      child: BlocProvider(
        create: (context) {
          final bloc = WeatherModuleBloc(
            weatherRepository: context.read<WeatherRepository>(),
          );

          bloc.add(const InitWeather());
          return bloc;
        },
        child: child,
      ),
    );
  }
}
