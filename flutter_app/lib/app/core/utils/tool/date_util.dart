import 'package:intl/intl.dart';

class DateUtil {
  static String formattedDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  static String formattedDateByString(int year, int month, int day) {
    String newMonth = month < 10 ? "0$month" : "$month";
    String newDay = day < 10 ? "0$day" : "$day";
    String date = "$year-$newMonth-$newDay";
    DateTime dateTime = DateTime.parse(date);
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }
}
