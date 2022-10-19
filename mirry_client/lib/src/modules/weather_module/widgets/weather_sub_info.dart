import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/utils/weather_utils.dart';
import 'package:mirry_client/src/modules/weather_module/widgets/weather_sub_info_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mirry_client/src/widgets/list_divider.dart';

class WeatherSubInfo extends StatelessWidget {
  const WeatherSubInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherModuleBloc, WeatherModuleState>(
      builder: (context, state) {
        return AnimatedContainer(
          width: 250,
          padding: const EdgeInsets.all(16),
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
          ),
          child: state.weather == null
              ? Container()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.feelsLike}:',
                      value: '${state.weather!.main.feelsLike.round()}°',
                    ),
                    const ListDivider(),
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.humidity}:',
                      value: '${state.weather!.main.humidity}%',
                    ),
                    const ListDivider(),
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.visibility}:',
                      value: '${state.weather!.visibility} m.',
                    ),
                    const ListDivider(),
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.windSpeed}:',
                      value: '${state.weather!.wind.speed} m/s',
                    ),
                    const ListDivider(),
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.sunrise}:',
                      value: WeatherUtils.getFormattedSysDetails(
                        state.weather!.sys.sunrise,
                      ),
                    ),
                    const ListDivider(),
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.sunset}:',
                      value: WeatherUtils.getFormattedSysDetails(
                        state.weather!.sys.sunset,
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
