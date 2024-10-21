import 'package:intl/intl.dart';

class DateUtil {
  static String formattedDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }
}
