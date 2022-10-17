import 'package:mirry_client/src/repositories/weather_repository/src/models/coordinates.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/weather.dart';

abstract class IWeatherRepository {
  Future<Weather> getCurrentWeather({
    required Coordinates coordinates,
  });
}
