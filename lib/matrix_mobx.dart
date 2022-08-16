import 'package:calendar/status.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

part 'matrix_mobx.g.dart';

// ignore: library_private_types_in_public_api
class Statuses = _Statuses with _$Statuses;

abstract class _Statuses with Store {
  @observable
  Map<DateTime, ObservableList<ObservableList<Status?>>> matrixStatus = {};

  @observable
  ObservableList<DateTime?> rangeDates = ObservableList.of([null, null]);

  @action
  // Создаёт матрицу статусов для каждого дня
  void initMatrixStatus(List<List<DateTime?>> matrixDate) {
    // По умолчанию все дни доступны
    for (int week = 0; week < matrixDate.length; week++) {
      matrixStatus[matrixDate]!.add(ObservableList.of([
        Status.def,
        Status.def,
        Status.def,
        Status.def,
        Status.def,
        Status.def,
        Status.def
      ]));
      // Проверка каждого дня на неделе
      for (int day = 0; day < 7; day++) {
        // Если день идёт ДО сегодняшнего, то ему присваивается статус "Прошедший"
        if (matrixDate[week][day] != null) {
          if (matrixDate[week][day]!.isBefore(DateTime.now()) &&
              matrixDate[week][day]!.day != DateTime.now().day) {
            matrixStatus[matrixDate]![week].insert(day, Status.before);
            // Если день сегодняшний - ему присваивается статус "Сегодняшний день доступный"
          } else if (matrixDate[week][day]!.day == DateTime.now().day &&
              matrixDate[week][day]!.month == DateTime.now().month &&
              matrixDate[week][day]!.year == DateTime.now().year) {
            matrixStatus[matrixDate]![week].insert(day, Status.defaultToday);
          }
        } else {
          matrixStatus[matrixDate]![week].insert(day, null);
        }
      }
    }
  }

  @action
  void addToRange(
      DateTime? pickedDate, DateTime indexMonth, int week, int day) {
    if (rangeDates[0] == null && rangeDates[1] == null) {
      rangeDates[0] = pickedDate;
      matrixStatus[indexMonth]![week][day] = Status.choosen;
    } else if (rangeDates[0] != null && rangeDates[1] == null) {
      rangeDates[1] = pickedDate;
      matrixStatus[indexMonth]![week][day] = Status.choosen;
    } else if (rangeDates[0] != pickedDate && rangeDates[1] != pickedDate) {
      if (rangeDates[1]!.isBefore(pickedDate!)) {
        List<int> oldDay = getCountWeeks(rangeDates[1]!);
        matrixStatus[indexMonth]![week][day] = Status.choosen;
        matrixStatus[DateTime(rangeDates[1]!.year, rangeDates[1]!.month, 1)]![
            oldDay[0] - 1][oldDay[1] - 1] = Status.def;
        rangeDates[1] = pickedDate;
      } else {
        List<int> oldDay = getCountWeeks(rangeDates[0]!);
        matrixStatus[indexMonth]![week][day] = Status.choosen;
        matrixStatus[DateTime(rangeDates[0]!.year, rangeDates[0]!.month, 1)]![
            oldDay[0] - 1][oldDay[1] - 1] = Status.def;
        rangeDates[0] = pickedDate;
      }
    }
  }

  @action
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
}
