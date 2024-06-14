import 'package:flutter/material.dart';

String formatTimeOfDay(TimeOfDay timeOfDay) {
  // Extract hours and minutes from TimeOfDay object
  final int hour = timeOfDay.hour;
  final int minute = timeOfDay.minute;

  // Determine if it's AM or PM
  final String period = hour < 12 ? 'AM' : 'PM';

  // Convert hour from 24-hour format to 12-hour format
  int formattedHour = hour % 12;
  formattedHour = formattedHour == 0 ? 12 : formattedHour;

  // Format minutes with leading zero if needed
  final String formattedMinute = minute < 10 ? '0$minute' : '$minute';

  // Concatenate all parts into a formatted string
  return '$formattedHour:$formattedMinute $period';
}