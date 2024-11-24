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

  static String formatTime(int dateTime) {
    final now = DateTime.now();
    final timestamp = DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
    final difference = now.difference(timestamp);
    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(timestamp);
    }
  }

  static String formatTimeEn(int dateTime) {
    final now = DateTime.now();
    final timestamp = DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(timestamp);
    }
  }
}
