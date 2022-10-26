import 'package:mirry_client/src/repositories/calendar_repository/calendar_repository.dart';

abstract class ICalendarRepository {
  Future<List<Event>> getEvents({
    required String calendarId,
    required String user,
    required String minDate,
    required String maxDate,
  });
}
