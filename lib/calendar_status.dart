import 'package:calendar/functions.dart';
import 'package:calendar/status.dart';
import 'package:flutter/cupertino.dart';

class CalendarStatus extends ChangeNotifier {
  final Map<DateTime, List<List<Status?>>> _matrixStatus = {};
  Map<DateTime, List<List<Status?>>> get matrixStatus => _matrixStatus;
  List<DateTime?> rangeDates = [null, null];

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
        // Если день идёт ДО сегодняшнего, то ему присваивается статус "Прошедший"
        if (matrixDate[i][n] != null) {
          if (matrixDate[i][n]!.isBefore(DateTime.now()) &&
              matrixDate[i][n]!.day != DateTime.now().day) {
            matrixStatus[currentKey]![i][n] = Status.before;
            // Если день сегодняшний - ему присваивается статус "Сегодняшний день доступный"
          } else if (matrixDate[i][n]!.day == DateTime.now().day &&
              matrixDate[i][n]!.month == DateTime.now().month &&
              matrixDate[i][n]!.year == DateTime.now().year) {
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
    } else {
      if (rangeDates[1]!.isBefore(pickedDate!)) {
        List<int> oldDay = getCountWeeks(rangeDates[1]!);
        matrixStatus[DateTime(dateTime.year, dateTime.month, 1)]![week][day] =
            Status.choosen;
        matrixStatus[DateTime(rangeDates[1]!.year, rangeDates[1]!.month, 1)]![
            oldDay[0] - 1][oldDay[1] - 1] = Status.def;
        rangeDates[1] = pickedDate;
      } else {
        List<int> oldDay = getCountWeeks(rangeDates[0]!);
        matrixStatus[DateTime(dateTime.year, dateTime.month, 1)]![week][day] =
            Status.choosen;
        matrixStatus[DateTime(rangeDates[0]!.year, rangeDates[0]!.month, 1)]![
            oldDay[0] - 1][oldDay[1] - 1] = Status.def;
        rangeDates[0] = pickedDate;
      }
    }
    notifyListeners();
  }
}
