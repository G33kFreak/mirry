import 'dart:developer';

import 'package:autoequal/autoequal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mirry_client/src/modules/calendar_module/utils/calendar_utils.dart';
import 'package:mirry_client/src/repositories/calendar_repository/calendar_repository.dart';

part 'calendar_module_event.dart';
part 'calendar_module_state.dart';
part 'calendar_module_bloc.g.dart';

class CalendarModuleBloc
    extends Bloc<CalendarModuleEvent, CalendarModuleState> {
  final ICalendarRepository _calendarRepository;

  CalendarModuleBloc({
    required ICalendarRepository calendarRepository,
  })  : _calendarRepository = calendarRepository,
        super(const CalendarModuleState()) {
    on<InitCalendar>(_onInitCalendar);
  }

  Future<void> _onInitCalendar(
    InitCalendar event,
    Emitter<CalendarModuleState> emit,
  ) async {
    final now = DateTime.now();
    final minDate = CalendarUtils.getMinDateOfDay(now);
    final maxDate = CalendarUtils.getMaxDateOfDay(now);

    // TODO: Add exception handler

    try {
      final events = await _calendarRepository.getEvents(
        calendarId: 'ruslan.zaripov@monterail.com',
        user: event.userId,
        minDate: '${minDate}Z',
        maxDate: '${maxDate}Z',
      );
      emit(state.copyWith(events: events));
    } catch (e) {
      log(e.toString());
    }
  }
}
