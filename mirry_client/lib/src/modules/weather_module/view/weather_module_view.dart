import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc.dart';
import 'package:mirry_client/src/modules/weather_module/bloc/weather_module_bloc_provider.dart';
import 'package:mirry_client/src/modules/weather_module/widgets/weather_main_info.dart';
import 'package:mirry_client/src/modules/weather_module/widgets/weather_sub_info.dart';

class WeatherModuleView extends StatelessWidget {
  const WeatherModuleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: WeatherModuleBlocProvider(
        child: BlocBuilder<WeatherModuleBloc, WeatherModuleState>(
          builder: (context, state) {
            return AnimatedSwitcher(
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  ...previousChildren,
                  if (currentChild != null) currentChild,
                ],
              ),
              duration: const Duration(milliseconds: 300),
              child: state.weather == null
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        WeatherMainInfo(),
                        WeatherSubInfo(),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
