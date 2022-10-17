part of 'weather_module_bloc.dart';

abstract class WeatherModuleEvent extends Equatable {
  const WeatherModuleEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitWeather extends WeatherModuleEvent with _$InitWeatherAutoequalMixin {
  const InitWeather();
}
