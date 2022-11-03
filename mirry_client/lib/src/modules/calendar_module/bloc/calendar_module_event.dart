part of 'calendar_module_bloc.dart';

abstract class CalendarModuleEvent extends Equatable {
  const CalendarModuleEvent();

  @override
  List<Object?> get props => [];
}

@autoequalMixin
class InitCalendar extends CalendarModuleEvent
    with _$InitCalendarAutoequalMixin {
  final String userId;

  const InitCalendar({required this.userId});
}
