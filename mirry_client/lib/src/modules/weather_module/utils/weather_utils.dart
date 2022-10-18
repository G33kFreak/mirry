import 'package:intl/intl.dart';

class WeatherUtils {
  static const _codesWithOneAnimation = [
    '04d',
    '04n',
    '03d',
    '03n',
    '09d',
    '09n',
    '10d',
    '10n',
    '11d',
    '11n',
    '50d',
    '50n',
  ];

  static String getWeatherAnimPath(String weatherIcon) {
    if (_codesWithOneAnimation.contains(weatherIcon)) {
      if (weatherIcon.contains('n')) {
        return weatherIcon.replaceAll('n', 'dn');
      }
      return weatherIcon.replaceAll('d', 'dn');
    }
    return weatherIcon;
  }

  static String getFormattedSysDetails(int timestamp) {
    final DateFormat format = DateFormat.Hm();
    final DateTime localTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(localTime);
  }
}
