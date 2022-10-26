import 'package:json_annotation/json_annotation.dart';

part 'event_date_info.g.dart';

@JsonSerializable()
class EventDateInfo {
  final DateTime dateTime;
  final String timeZone;

  const EventDateInfo({required this.dateTime, required this.timeZone});

  factory EventDateInfo.fromJson(Map<String, dynamic> json) =>
      _$EventDateInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EventDateInfoToJson(this);
}
