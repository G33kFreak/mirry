import 'package:dio/dio.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/coordinates.dart';

typedef GetWeather = Future<Response> Function(Dio, Coordinates);

final GetWeather getWeather = (
  Dio httpClient,
  Coordinates coordinates,
) =>
    httpClient.get('/weather/current', queryParameters: {
      'lat': coordinates.lat,
      'lon': coordinates.lon,
    });
