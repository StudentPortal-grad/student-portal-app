import 'package:timeago/timeago.dart' as timeago;

class TimeHelper {
  // Private constructor
  TimeHelper._privateConstructor();

  // Singleton instance
  static final TimeHelper _instance = TimeHelper._privateConstructor();

  // Getter to access the instance
  static TimeHelper get instance => _instance;

  // Function to convert DateTime to "time ago" format
  String timeAgo(DateTime? dateTime) {
    if(dateTime == null) return '';
    return timeago.format(dateTime, allowFromNow: true, locale: 'en'); // Example: "10m ago"
  }
}