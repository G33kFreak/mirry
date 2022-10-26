import 'package:dio/dio.dart';

typedef GetEvents = Future<Response> Function(
  Dio,
  String,
  String,
  String,
  String,
);

final GetEvents getEvents = (
  Dio httpClient,
  String calendarId,
  String user,
  String minDate,
  String maxDate,
) =>
    httpClient.get('/calendar/events', queryParameters: {
      'calendarId': calendarId,
      'user': user,
      'minDate': minDate,
      'maxDate': maxDate,
    });
