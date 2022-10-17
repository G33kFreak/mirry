import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/coordinates.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/weather.dart';
import 'package:mirry_client/src/repositories/weather_repository/weather_repository.dart';

part 'weather_module_event.dart';
part 'weather_module_state.dart';
part 'weather_module_bloc.g.dart';

class WeatherModuleBloc extends Bloc<WeatherModuleEvent, WeatherModuleState> {
  final IWeatherRepository _weatherRepository;

  WeatherModuleBloc({
    required IWeatherRepository weatherRepository,
  })  : _weatherRepository = weatherRepository,
        super(const WeatherModuleState()) {
    on<InitWeather>(_onInitWeather);
  }

  Future<void> _onInitWeather(
    InitWeather event,
    Emitter<WeatherModuleState> emit,
  ) async {
    //TODO: add granding permissions support
    final geolocation = await Geolocator.getCurrentPosition();

    final weatherResponse = await _weatherRepository.getCurrentWeather(
      coordinates: Coordinates(
        lon: geolocation.longitude,
        lat: geolocation.latitude,
      ),
    );

    emit(state.copyWith(weather: weatherResponse));
  }
}
