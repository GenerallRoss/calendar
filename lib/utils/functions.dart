import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../values/lists.dart';
import '../values/status.dart';

// Проверяем статус дня
Status whatStatusOfDay(DateTime date) {
  if (date.isBefore(DateTime.now()) && date.day != DateTime.now().day) {
    return Status.unavaible;
    // Если день сегодняшний - ему присваивается статус "Сегодняшний день доступный"
  } else if (DateUtils.isSameDay(date, DateTime.now()) &&
      DateUtils.isSameMonth(date, DateTime.now()) &&
      date.year == DateTime.now().year) {
    return Status.defaultToday;
  } else {
    return getRandomStatus();
  }
}

// Присваиваем статус наугад
Status getRandomStatus() {
  Random rng = Random();
  int randomNumber = rng.nextInt(2);
  switch (randomNumber) {
    case 0:
      return Status.avaible;
    default:
      return Status.unavaible;
  }
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
        String day1 = days[n];
        String day2 = DateFormat('EEEE')
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

// Возвращает количество недель в месяце
int getCountWeeks(DateTime date) {
  int days = DateUtils.getDaysInMonth(date.year, date.month);
  int result = 1;
  for (int i = 1; i < days; i++) {
    if (DateFormat('EEEE').format(DateTime(date.year, date.month, i)) ==
        'Monday') {
      result += 1;
    }
  }
  return result;
}
