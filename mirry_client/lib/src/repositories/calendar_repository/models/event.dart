import 'package:json_annotation/json_annotation.dart';
import 'package:mirry_client/src/repositories/calendar_repository/models/event_date_info.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final EventDateInfo start;
  final EventDateInfo end;
  final String summary;

  Event({
    required this.start,
    required this.end,
    required this.summary,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
