class CalendarUtils {
  static String getMinDateOfDay(DateTime now) {
    final start = DateTime(now.year, now.month, now.day);

    return start.toIso8601String();
  }

  static String getMaxDateOfDay(DateTime now) {
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return end.toIso8601String();
  }
}
