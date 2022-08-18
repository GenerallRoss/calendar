import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int getWeeks(DateTime date) {
  var days = DateUtils.getDaysInMonth(date.year, date.month);
  int result = 1;
  for (int i = 2; i < days + 1; i++) {
    if (DateFormat('EEEE').format(DateTime(date.year, date.month, i)) ==
        'Monday') {
      result += 1;
    }
  }
  return result;
}

List<List<DateTime?>> getMonthMatrix(DateTime date) {
  List<List<DateTime?>> matrix = [];
  int weeks = getWeeks(date);
  int index = 1;
  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  for (int i = 0; i < weeks; i++) {
    matrix.add([null, null, null, null, null, null, null]);
    for (int n = 0; n < 7; n++) {
      if (i == 0 && index == 1) {
        var day1 = days[n];
        var day2 = DateFormat('EEEE')
            .format(DateTime(date.year, date.month, date.day));
        if (day1 == day2) {
          matrix[i][n] = DateTime(date.year, date.month, index);
          index++;
        }
      } else if (index <= DateUtils.getDaysInMonth(date.year, date.month)) {
        matrix[i][n] = DateTime(date.year, date.month, index);
        index++;
      }
    }
  }
  return matrix;
}

List<int> getCountWeeks(DateTime date) {
  List<int> result = [1, date.weekday];
  DateTime tempDate = DateTime(date.year, date.month, 1);
  while (tempDate != date) {
    tempDate = DateTime(tempDate.year, tempDate.month, tempDate.day + 1);
    if (DateFormat('EEEE')
            .format(DateTime(tempDate.year, tempDate.month, tempDate.day)) ==
        'Monday') {
      result[0]++;
    }
  }
  return result;
}
