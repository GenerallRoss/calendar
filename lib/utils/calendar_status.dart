import 'package:flutter/cupertino.dart';

import '../values/status.dart';
import 'functions.dart';

class CalendarStatus extends ChangeNotifier {
  final Map<DateTime, List<List<Status?>>> _matrixStatus = {};
  Map<DateTime, List<List<Status?>>> get matrixStatus => _matrixStatus;
  List<DateTime?> rangeDates = [null, null];
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
      return Status.def;
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

  void addToRange(DateTime? pickedDate, DateTime dateTime, int week, int day) {
    if (rangeDates[0] == null && rangeDates[1] == null) {
      rangeDates[0] = pickedDate;
      matrixStatus[DateTime(dateTime.year, dateTime.month, 1)]![week][day] =
          Status.choosen;
    } else if (rangeDates[0] != null && rangeDates[1] == null) {
      rangeDates[1] = pickedDate;
      matrixStatus[DateTime(dateTime.year, dateTime.month, 1)]![week][day] =
          Status.choosen;
      if (rangeDates[1]!.isBefore(rangeDates[0]!)) {
        DateTime temp = rangeDates[0]!;
        rangeDates[0] = rangeDates[1];
        rangeDates[1] = temp;
      }
      rewriteStatus(false);
    } else {
      List<int> firstRange = getCountWeeks(rangeDates[0]!);
      List<int> secondRange = getCountWeeks(rangeDates[1]!);
      matrixStatus[DateTime(rangeDates[0]!.year, rangeDates[0]!.month, 1)]![
              firstRange[0] - 1][firstRange[1] - 1] =
          whatStatusOfDay(rangeDates[0]!);
      matrixStatus[DateTime(rangeDates[1]!.year, rangeDates[1]!.month, 1)]![
              secondRange[0] - 1][secondRange[1] - 1] =
          whatStatusOfDay(rangeDates[1]!);
      rewriteStatus(true);
      rangeDates[0] = pickedDate;
      matrixStatus[DateTime(rangeDates[0]!.year, rangeDates[0]!.month, 1)]![
          week][day] = Status.choosen;
      rangeDates[1] = null;
    }
    notifyListeners();
  }

  void rewriteStatus(bool isNew) {
    DateTime? firstDate = rangeDates[0];
    DateTime? secondDate = rangeDates[1];
    while (firstDate !=
        DateTime(secondDate!.year, secondDate.month, secondDate.day - 1)) {
      firstDate = DateTime(firstDate!.year, firstDate.month, firstDate.day + 1);
      List<int> dayMatrix = getCountWeeks(firstDate);
      DateTime currentDay = DateTime(firstDate.year, firstDate.month, 1);
      if (!isNew) {
        matrixStatus[currentDay]![dayMatrix[0] - 1][dayMatrix[1] - 1] =
            Status.ranged;
      } else {
        matrixStatus[currentDay]![dayMatrix[0] - 1][dayMatrix[1] - 1] =
            whatStatusOfDay(firstDate);
      }
    }
    notifyListeners();
  }
}
