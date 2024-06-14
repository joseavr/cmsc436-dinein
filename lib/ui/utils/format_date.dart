String formatDate(String timestampString) {
  // Parse the timestamp string to a DateTime object
  DateTime timestamp = DateTime.parse(timestampString);

  // Get the current time
  DateTime now = DateTime.now();

  // Calculate the time difference
  Duration difference = now.difference(timestamp);

  // Calculate the difference in minutes, hours, days, months, and years
  int minutes = difference.inMinutes;
  int hours = difference.inHours;
  int days = difference.inDays;
  int months = (now.year - timestamp.year) * 12 + now.month - timestamp.month;
  int years = now.year - timestamp.year;

  // Determine the appropriate time unit
  if (years > 0) {
    return '$years year${years == 1 ? '' : 's'} ago';
  } else if (months > 0) {
    return '$months month${months == 1 ? '' : 's'} ago';
  } else if (days > 0) {
    return '$days day${days == 1 ? '' : 's'} ago';
  } else if (hours > 0) {
    return '$hours hour${hours == 1 ? '' : 's'} ago';
  } else {
    return '$minutes minute${minutes == 1 ? '' : 's'} ago';
  }
}
