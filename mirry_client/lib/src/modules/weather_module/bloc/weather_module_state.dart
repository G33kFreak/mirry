part of 'weather_module_bloc.dart';

@autoequalMixin
class WeatherModuleState extends Equatable
    with _$WeatherModuleStateAutoequalMixin {
  final Weather? weather;

  const WeatherModuleState({this.weather});

  WeatherModuleState copyWith({Weather? weather}) => WeatherModuleState(
        weather: weather,
      );
}
