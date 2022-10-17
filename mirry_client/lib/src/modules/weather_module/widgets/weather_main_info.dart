import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/utils/weather_utils.dart';

class WeatherMainInfo extends StatelessWidget {
  const WeatherMainInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherModuleBloc, WeatherModuleState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animations/weather/${WeatherUtils.getWeatherAnimPath(state.weather!.weather[0].icon)}.json',
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${state.weather!.main.temp.round()}°',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  state.weather!.weather[0].description,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
