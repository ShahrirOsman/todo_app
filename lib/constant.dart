import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const kBoldTitle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const kButtonTextStyle = TextStyle(color: Colors.white);
final kLabelTextStyle = TextStyle(color: Colors.grey[600]);

DateFormat dateFormat = DateFormat('d MMMM yyyy');

DateFormat timeFormat = DateFormat('kk:mm a');
DateFormat dateTimeFormat = DateFormat('d MMMM yyyy, kk:mm a');

DateTime joinDateTime(DateTime date, TimeOfDay time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}
