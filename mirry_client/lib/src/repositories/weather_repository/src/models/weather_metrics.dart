import 'package:json_annotation/json_annotation.dart';

part 'weather_metrics.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WeatherMetrics {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;

  const WeatherMetrics({
    required this.temp,
    required this.feelsLike,
    required this.tempMax,
    required this.tempMin,
    required this.humidity,
  });

  factory WeatherMetrics.fromJson(Map<String, dynamic> json) =>
      _$WeatherMetricsFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherMetricsToJson(this);
}
