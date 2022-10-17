import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc_provider.dart';

class WeatherModuleView extends StatelessWidget {
  const WeatherModuleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WeatherModuleBlocProvider(
      child: BlocBuilder<WeatherModuleBloc, WeatherModuleState>(
        builder: (context, state) {
          return Text(state.weather?.main.temp.toString() ?? 'placeholder');
        },
      ),
    );
  }
}
