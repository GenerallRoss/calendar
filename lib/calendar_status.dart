import 'package:calendar/functions.dart';
import 'package:calendar/status.dart';
import 'package:flutter/cupertino.dart';

class CalendarStatus extends ChangeNotifier {
  final Map<DateTime, List<List<Status?>>> _matrixStatus = {};
  Map<DateTime, List<List<Status?>>> get matrixStatus => _matrixStatus;
  List<DateTime?> rangeDates = [null, null];
  bool leftOrRight = true;

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
          if (currentDay.isBefore(DateTime.now()) &&
              currentDay.day != DateTime.now().day) {
            matrixStatus[currentKey]![i][n] = Status.before;
            // Если день сегодняшний - ему присваивается статус "Сегодняшний день доступный"
          } else if (currentDay.day == DateTime.now().day &&
              currentDay.month == DateTime.now().month &&
              currentDay.year == DateTime.now().year) {
            matrixStatus[currentKey]![i][n] = Status.defaultToday;
          }
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
      rewriteStatus();
    } else if (pickedDate != rangeDates[0] && pickedDate != rangeDates[1]) {
      if (rangeDates[1]!.isBefore(pickedDate!)) {
        List<int> oldDay = getCountWeeks(rangeDates[1]!);
        matrixStatus[DateTime(rangeDates[1]!.year, rangeDates[1]!.month, 1)]![
            oldDay[0] - 1][oldDay[1] - 1] = Status.def;
        clearSelected();
        if (leftOrRight) {
          rangeDates[1] = pickedDate;
        } else {
          rangeDates[0] = pickedDate;
        }
        rewriteStatus();
        matrixStatus[DateTime(dateTime.year, dateTime.month, 1)]![week][day] =
            Status.choosen;
      } else {
        List<int> oldDay = getCountWeeks(rangeDates[0]!);
        matrixStatus[DateTime(rangeDates[0]!.year, rangeDates[0]!.month, 1)]![
            oldDay[0] - 1][oldDay[1] - 1] = Status.def;
        clearSelected();
        if (leftOrRight) {
          rangeDates[0] = pickedDate;
        } else {
          rangeDates[1] = pickedDate;
        }
        rewriteStatus();
        matrixStatus[DateTime(dateTime.year, dateTime.month, 1)]![week][day] =
            Status.choosen;
      }
    }
    notifyListeners();
  }

  void rewriteStatus() {
    DateTime? firstDate = rangeDates[0];
    DateTime? secondDate = rangeDates[1];
    while (firstDate !=
        DateTime(secondDate!.year, secondDate.month, secondDate.day - 1)) {
      firstDate = DateTime(firstDate!.year, firstDate.month, firstDate.day + 1);
      List<int> dayMatrix = getCountWeeks(firstDate);
      DateTime currentDay = DateTime(firstDate.year, firstDate.month, 1);
      matrixStatus[currentDay]![dayMatrix[0] - 1][dayMatrix[1] - 1] =
          Status.ranged;
    }
    notifyListeners();
  }

  void clearSelected() {
    DateTime? firstDate = rangeDates[0];
    DateTime? secondDate = rangeDates[1];
    while (firstDate !=
        DateTime(secondDate!.year, secondDate.month, secondDate.day - 1)) {
      firstDate = DateTime(firstDate!.year, firstDate.month, firstDate.day + 1);
      List<int> dayMatrix = getCountWeeks(firstDate);
      DateTime currentDay = DateTime(firstDate.year, firstDate.month, 1);
      matrixStatus[currentDay]![dayMatrix[0] - 1][dayMatrix[1] - 1] =
          Status.def;
    }
    notifyListeners();
  }
}
