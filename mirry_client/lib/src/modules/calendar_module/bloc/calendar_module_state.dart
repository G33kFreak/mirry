part of 'calendar_module_bloc.dart';

@autoequalMixin
class CalendarModuleState extends Equatable
    with _$CalendarModuleStateAutoequalMixin {
  final List<Event> events;

  const CalendarModuleState({this.events = const []});

  CalendarModuleState copyWith({
    List<Event>? events,
  }) =>
      CalendarModuleState(
        events: events ?? this.events,
      );
}
