import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../values/status.dart';
import 'functions.dart';

class CalendarStatus extends ChangeNotifier {
  final Map<DateTime, List<List<Status?>>> _matrixStatus = {};
  Map<DateTime, List<List<Status?>>> get matrixStatus => _matrixStatus;
  DateTime? selectedDate;
  bool leftOrRight = true;

  Status whatStatusOfDay(DateTime date) {
    if (date.isBefore(DateTime.now()) && date.day != DateTime.now().day) {
      return Status.unavaible;
      // Если день сегодняшний - ему присваивается статус "Сегодняшний день доступный"
    } else if (date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      return Status.defaultToday;
    } else {
      return getRandomStatus();
    }
  }

  Status getRandomStatus() {
    var rng = Random();
    int randomNumber = rng.nextInt(2);
    switch (randomNumber) {
      case 0:
        return Status.avaible;
      default:
        return Status.unavaible;
    }
  }

// Создаёт матрицу статусов для каждого дня
  void initMatrixStatus(List<List<DateTime?>> matrixDate) {
    DateTime currentKey =
        DateTime(matrixDate[1][0]!.year, matrixDate[1][0]!.month, 1);
    matrixStatus[currentKey] = [];
    // По умолчанию все дни доступны
    for (int i = 0; i < matrixDate.length; i++) {
      matrixStatus[currentKey]!.add([]);
      matrixStatus[currentKey]![i] = ([
        Status.def,
        Status.def,
        Status.def,
        Status.def,
        Status.def,
        Status.def,
        Status.def
      ]);
      // Проверка каждого дня на неделе
      for (int n = 0; n < 7; n++) {
        DateTime? currentDay = matrixDate[i][n];
        // Если день идёт ДО сегодняшнего, то ему присваивается статус "Прошедший"
        if (currentDay != null) {
          matrixStatus[currentKey]![i][n] = whatStatusOfDay(currentDay);
        } else {
          matrixStatus[currentKey]![i][n] = null;
        }
      }
    }
  }

  void selectDate(DateTime pickedDate) {
    List<int> weekAndDay = getWeekAndDay(pickedDate);
    DateTime currentDate = DateTime(pickedDate.year, pickedDate.month, 1);
    debugPrint(weekAndDay.toString());
    if (selectedDate == null) {
      selectedDate = pickedDate;
      matrixStatus[currentDate]![weekAndDay[0]][weekAndDay[1]] =
          Status.selected;
    } else {
      List<int> oldWeekAndDay = getWeekAndDay(selectedDate!);
      DateTime oldDate = DateTime(selectedDate!.year, selectedDate!.month, 1);
      matrixStatus[oldDate]![oldWeekAndDay[0]][oldWeekAndDay[1]] =
          Status.avaible;
      selectedDate = pickedDate;
      matrixStatus[currentDate]![weekAndDay[0]][weekAndDay[1]] =
          Status.selected;
    }
    notifyListeners();
  }
}
