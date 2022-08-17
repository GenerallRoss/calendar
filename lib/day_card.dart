// ignore_for_file: unrelated_type_equality_checks

import 'package:calendar/constants.dart';
import 'package:calendar/status.dart';
import 'package:flutter/material.dart';

import 'calendar_status.dart';

Widget dayCard(List<List<DateTime?>> matrixDate, DateTime currentDate, int week,
    int day, CalendarStatus calendarStatus) {
  var currentStatus = calendarStatus.matrixStatus[currentDate]![week][day];
  var thisDate = matrixDate[week][day];
  List<double> borderSide = [0, 0, 0, 0];

  bool isDayFirst(DateTime? currentDay) {
    return !(DateUtils.isSameMonth(currentDay,
        DateTime(currentDay!.year, currentDay.month, currentDay.day - 1)));
  }

  bool isDayLast(DateTime? currentDay) {
    return !(DateUtils.isSameMonth(currentDay,
        DateTime(currentDay!.year, currentDay.month, currentDay.day + 1)));
  }

  if (currentStatus != Status.ranged) {
    borderSide = [10, 10, 10, 10];
  } else if (day == 6 || isDayLast(thisDate)) {
    borderSide = [0, 0, 10, 10];
  } else if (day == 0 || isDayFirst(thisDate)) {
    borderSide = [10, 10, 0, 0];
  }

  return Padding(
    padding:
        (calendarStatus.matrixStatus[currentDate]![week][day] == Status.ranged)
            ? const EdgeInsets.symmetric(vertical: 5)
            : (calendarStatus.matrixStatus[currentDate]![week][day] ==
                    Status.choosen)
                ? const EdgeInsets.all(0)
                : const EdgeInsets.all(3.5),
    child: Container(
      decoration: BoxDecoration(
          // Если день доступен
          color: (calendarStatus.matrixStatus[currentDate]![week][day] == Status.avaible ||
                  calendarStatus.matrixStatus[currentDate]![week][day] ==
                      Status.avaibleToday)
              ? Colors.white
              // Если день недоступен
              : (calendarStatus.matrixStatus[currentDate]![week][day] == Status.unavaible ||
                      calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.unavaibleToday)
                  ? const Color.fromARGB(175, 214, 214, 214)
                  // День "По умолчанию"
                  : (calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.choosen)
                      ? Colors.black
                      : (calendarStatus.matrixStatus[currentDate]![week][day] ==
                              Status.ranged)
                          ? Colors.grey
                          : Colors.transparent,
          border: Border.all(
              color:
                  (calendarStatus.matrixStatus[currentDate]![week][day] == Status.avaibleToday ||
                          calendarStatus.matrixStatus[currentDate]![week][day] ==
                              Status.unavaibleToday ||
                          calendarStatus.matrixStatus[currentDate]![week][day] ==
                              Status.defaultToday)
                      ? Colors.black
                      : Colors.transparent,
              width: 2.5),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderSide[0]),
              bottomLeft: Radius.circular(borderSide[1]),
              topRight: Radius.circular(borderSide[2]),
              bottomRight: Radius.circular(borderSide[3]))),
      child: Center(
        child: Text(
          (matrixDate[week][day]?.day.toString() != null)
              ? matrixDate[week][day]!.day.toString()
              : '',
          textAlign: TextAlign.center,
          style: (
                  calendarStatus.matrixStatus[currentDate]![week][day] ==
                      Status.unavaible ||
                  calendarStatus.matrixStatus[currentDate]![week][day] ==
                      Status.unavaibleToday)
              ? unavaibleTextStyle
              : (calendarStatus.matrixStatus[currentDate]![week][day] ==
                      Status.choosen)
                  ? choosenTextStyle
                  : defaultTextStyle,
        ),
      ),
    ),
  );
}
