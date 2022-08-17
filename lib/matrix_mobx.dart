import 'package:calendar/status.dart';
import 'package:intl/intl.dart';

Map<DateTime, List<List<Status?>>> matrixStatus = {};

List<DateTime?> rangeDates = [null, null];

// Создаёт матрицу статусов для каждого дня
List<List<Status?>> initMatrixStatus(List<List<DateTime?>> matrixDate) {
  List<List<Status?>> matrixStatus = [];
  // По умолчанию все дни доступны
  for (int i = 0; i < matrixDate.length; i++) {
    matrixStatus.add([
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
          matrixStatus[i][n] = Status.before;
          // Если день сегодняшний - ему присваивается статус "Сегодняшний день доступный"
        } else if (matrixDate[i][n]!.day == DateTime.now().day &&
            matrixDate[i][n]!.month == DateTime.now().month &&
            matrixDate[i][n]!.year == DateTime.now().year) {
          matrixStatus[i][n] = Status.defaultToday;
        }
      } else {
        matrixStatus[i][n] = null;
      }
    }
  }
  return matrixStatus;
}

void addToRange(DateTime? pickedDate, DateTime dateTime, int week, int day) {
  if (rangeDates[0] == null && rangeDates[1] == null) {
    rangeDates[0] = pickedDate;
    matrixStatus[dateTime]![week][day] = Status.choosen;
  } else if (rangeDates[0] != null && rangeDates[1] == null) {
    rangeDates[1] = pickedDate;
    matrixStatus[dateTime]![week][day] = Status.choosen;
  } else {
    if (rangeDates[1]!.isBefore(pickedDate!)) {
      List<int> oldDay = getCountWeeks(rangeDates[1]!);
      matrixStatus[dateTime]![week][day] = Status.choosen;
      matrixStatus[DateTime(rangeDates[1]!.year, rangeDates[1]!.month, 1)]![
          oldDay[0] - 1][oldDay[1] - 1] = Status.def;
      rangeDates[1] = pickedDate;
    } else {
      List<int> oldDay = getCountWeeks(rangeDates[0]!);
      matrixStatus[dateTime]![week][day] = Status.choosen;
      matrixStatus[DateTime(rangeDates[0]!.year, rangeDates[0]!.month, 1)]![
          oldDay[0] - 1][oldDay[1] - 1] = Status.def;
      rangeDates[0] = pickedDate;
    }
  }
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
