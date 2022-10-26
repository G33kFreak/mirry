import 'package:flutter/material.dart';
import 'package:mirry_client/src/repositories/calendar_repository/models/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> events) {
    appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments![index] as Event).start.dateTime.toLocal();
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments![index] as Event).end.dateTime.toLocal();
  }

  @override
  String getSubject(int index) {
    return (appointments![index] as Event).summary;
  }

  @override
  Color getColor(int index) {
    final endTime = getEndTime(index);
    final now = DateTime.now().toLocal();

    if (now.isAfter(endTime)) {
      return Colors.grey.withOpacity(0.5);
    }

    return Colors.white.withOpacity(0.8);
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
