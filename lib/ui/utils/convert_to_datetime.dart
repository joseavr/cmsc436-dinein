DateTime convertToDateTime(String date, String time) {
  // Parse date string
  List<String> dateParts = date.split('-');
  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);

  // Parse time string
  List<String> timeParts = time.split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1].split(' ')[0]);
  int hourOffset = time.contains('PM') ? 12 : 0;

  // Create DateTime object
  DateTime dateTime = DateTime(year, month, day, hour + hourOffset, minute);

  return dateTime;
}
