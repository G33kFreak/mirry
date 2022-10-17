import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/widgets/weather_sub_info_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WeatherSubInfo extends StatelessWidget {
  const WeatherSubInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherModuleBloc, WeatherModuleState>(
      builder: (context, state) {
        return AnimatedContainer(
          width: 200,
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
                      value: state.weather!.main.feelsLike.toString(),
                    ),
                    const _Divider(),
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.humidity}:',
                      value: '${state.weather!.main.humidity}%',
                    ),
                    const _Divider(),
                    WeatherSubInfoItem(
                      title: '${AppLocalizations.of(context)!.visibility}:',
                      value: '${state.weather!.visibility} m.',
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Divider(height: 1),
    );
  }
}
