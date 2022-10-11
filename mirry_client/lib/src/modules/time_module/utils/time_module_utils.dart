import 'package:intl/intl.dart';

class TimeModuleUtils {
  static getFormattedDate(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('EEEE, MMMM, dd, yyyy');
    return dateFormat.format(dateTime);
  }

  static getFormattedTime(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.format(dateTime);
  }
}
