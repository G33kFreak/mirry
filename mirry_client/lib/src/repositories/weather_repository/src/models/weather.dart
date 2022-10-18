import 'package:json_annotation/json_annotation.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/coordinates.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/weather_description.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/weather_metrics.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/weather_system.dart';
import 'package:mirry_client/src/repositories/weather_repository/src/models/wind.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final Coordinates coord;
  final List<WeatherDescription> weather;
  final WeatherMetrics main;
  final int visibility;
  final Wind wind;
  final WeatherSystem sys;

  const Weather({
    required this.coord,
    required this.weather,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.sys,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}
