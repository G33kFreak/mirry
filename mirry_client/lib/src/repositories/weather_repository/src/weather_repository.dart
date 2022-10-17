import 'package:dio/dio.dart';
import 'package:mirry_client/src/config/api/exceptions.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/api/weather_endpoints.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/coordinates.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/weather.dart';
import 'package:mirry_client/src/repositories/weather_repository/weather_repository.dart';

class WeatherRepository implements IWeatherRepository {
  final Dio _httpClient;
  final GetWeather _getWeather;

  const WeatherRepository({
    required Dio httpClient,
    required GetWeather getWeather,
  })  : _httpClient = httpClient,
        _getWeather = getWeather;

  @override
  Future<Weather> getCurrentWeather({
    required Coordinates coordinates,
  }) async {
    final response = await _getWeather(_httpClient, coordinates);
    try {
      return Weather.fromJson(response.data);
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
