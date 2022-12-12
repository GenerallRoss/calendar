import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../values/lists.dart';
import '../values/status.dart';

/// Проверка статуса дня
///
/// Может вернуть [Status.unavaible], [Status.avaible] или [Status.defaultToday]
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

/// Функция, для присваивания статуса дню (доступен или недоступен)
///
/// Высчитывается наугад, с 50% шансом для каждого статуса
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

/// Возвращает матрицу дней в месяце.
///
/// Сначала вызывается функция [getCountWeeks] для рассчитываемого месяца для подсчёта количества недель в месяце.
/// Затем это значение записывается в переменную [weeks].
///
/// Создаётся матрица размером 7х[weeks], которая и будет отображать рассчитываемый месяц.
/// Либо в ячейке матрицы содержится дата, либо null, если нет даты на выбранную ячейку матрицы.
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

  /// Происходит 4-5 итераций.
  /// В каждой добавляется по одной строке (неделе).
  for (int i = 0; i < weeks; i++) {
    matrix.add([]);

    /// В каждой итерации происходит ещё 7 итераций для каждого дня недели
    for (int n = 0; n < Configuration.dayCount; n++) {
      matrix[i].add(null);
    }

    for (int n = 0; n < Configuration.dayCount; n++) {
      /// Для первой недели происходит особый расчёт
      /// Если в месяце в первой неделе нет какого-либо дня недели, то в матрице это значение остаётся как null
      if (i == 0 && index == 1) {
        String day1 = days[n];
        String day2 = DateFormat('EEEE')
            .format(DateTime(date.year, date.month, date.day));
        if (day1 == day2) {
          matrix[i][n] = DateTime(date.year, date.month, index);
          index++;
        }

        /// В остальных случаях, матрица просто заполняется, пока не дойдёт до последнего дня месяца
      } else if (index <= DateUtils.getDaysInMonth(date.year, date.month)) {
        matrix[i][n] = DateTime(date.year, date.month, index);
        index++;
      }
    }
  }
  return matrix;
}

/// Возвращает количество недель в месяце.
///
/// Считается по формуе 'количество понедельников в месяце' + 1.
/// (Если месяц начинается с понедельника, то он не учитывается).
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
