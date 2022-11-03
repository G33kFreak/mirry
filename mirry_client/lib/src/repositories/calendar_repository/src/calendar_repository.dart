import 'package:dio/dio.dart';
import 'package:mirry_client/src/config/api/exceptions.dart';
import 'package:mirry_client/src/repositories/calendar_repository/calendar_repository.dart';

class CalendarRepository implements ICalendarRepository {
  final Dio _httpClient;
  final GetEvents _getEvents;

  const CalendarRepository({
    required Dio httpClient,
    required GetEvents getEvents,
  })  : _httpClient = httpClient,
        _getEvents = getEvents;

  @override
  Future<List<Event>> getEvents({
    required String calendarId,
    required String user,
    required String minDate,
    required String maxDate,
  }) async {
    final response = await _getEvents(
      _httpClient,
      calendarId,
      user,
      minDate,
      maxDate,
    );
    try {
      return (response.data as List).map((e) => Event.fromJson(e)).toList();
    } catch (e) {
      throw ApiResponseParseException(e.toString());
    }
  }
}
