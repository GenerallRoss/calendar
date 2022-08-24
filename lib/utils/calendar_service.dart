import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../values/lists.dart';
import '../values/status.dart';
import 'functions.dart';

class CalendarService extends ChangeNotifier {
  final Map<DateTime, List<List<Status?>>> _matrixStatus = {};
  Map<DateTime, List<List<Status?>>> get matrixStatus => _matrixStatus;
  DateTime? selectedDate;
  bool leftOrRight = true;

// Создаёт матрицу статусов для каждого дня
  void initMatrixStatus(List<List<DateTime?>> matrixDate,
      [List<List<Status?>>? newMatrixStatus]) {
    DateTime currentKey =
        DateTime(matrixDate[1][0]!.year, matrixDate[1][0]!.month, 1);
    matrixStatus[currentKey] = [];
    // По умолчанию все дни доступны
    for (int i = 0; i < matrixDate.length; i++) {
      matrixStatus[currentKey]!.add([]);
      // Проверка каждого дня на неделе
      for (int n = 0; n < dayCount; n++) {
        matrixStatus[currentKey]![i].add(Status.def);
      }
      for (int n = 0; n < dayCount; n++) {
        DateTime? currentDay = matrixDate[i][n];
        // Если день идёт ДО сегодняшнего, то ему присваивается статус "Прошедший"
        if (currentDay != null) {
          if (newMatrixStatus == null) {
            matrixStatus[currentKey]![i][n] = whatStatusOfDay(currentDay);
          } else {
            matrixStatus[currentKey]![i][n] = newMatrixStatus[i][n];
          }
        } else {
          matrixStatus[currentKey]![i][n] = null;
        }
      }
    }
  }

  void selectDate(List<List<DateTime?>> matrix, int week, int day) {
    DateTime? pickedDate = matrix[week][day];
    if (pickedDate != null) {
      DateTime currentDate = DateTime(pickedDate.year, pickedDate.month, 1);
      if (matrixStatus[currentDate]![week][day] != Status.unavaible) {
        List<int> weekAndDay = getWeekAndDay(pickedDate);

        if (selectedDate == null) {
          selectedDate = pickedDate;
          matrixStatus[currentDate]![weekAndDay[0]][weekAndDay[1]] =
              Status.selected;
        } else {
          List<int> oldWeekAndDay = getWeekAndDay(selectedDate!);
          DateTime oldDate =
              DateTime(selectedDate!.year, selectedDate!.month, 1);
          matrixStatus[oldDate]![oldWeekAndDay[0]][oldWeekAndDay[1]] =
              Status.avaible;
          selectedDate = pickedDate;
          matrixStatus[currentDate]![weekAndDay[0]][weekAndDay[1]] =
              Status.selected;
        }
        notifyListeners();
      }
    }
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
}
