import 'package:json_annotation/json_annotation.dart';

part 'weather_system.g.dart';

@JsonSerializable()
class WeatherSystem {
  final int sunrise;
  final int sunset;

  const WeatherSystem({required this.sunrise, required this.sunset});

  factory WeatherSystem.fromJson(Map<String, dynamic> json) =>
      _$WeatherSystemFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherSystemToJson(this);
}
