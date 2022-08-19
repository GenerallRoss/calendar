import 'package:calendar/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Возвращает количество недель в месяце
int getCountWeeks(DateTime date) {
  var days = DateUtils.getDaysInMonth(date.year, date.month);
  int result = 1;
  for (int i = 1; i < days; i++) {
    if (DateFormat('EEEE').format(DateTime(date.year, date.month, i)) ==
        'Monday') {
      result += 1;
    }
  }
  return result;
}

// Возвращает матрицу дней в месяце
List<List<DateTime?>> getMonthMatrix(DateTime date) {
  List<List<DateTime?>> matrix = [];
  int weeks = getCountWeeks(date);
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
    matrix.add([]);
    for (int n = 0; n < dayCount; n++) {
      matrix[i].add(null);
    }

    for (int n = 0; n < dayCount; n++) {
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

// Возвращает номер недели и дня в месяце (в матричном виде)
List<int> getWeekAndDay(DateTime date) {
  List<int> result = [0, date.weekday - 1];
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
