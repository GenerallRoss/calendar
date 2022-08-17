// ignore_for_file: unrelated_type_equality_checks

import 'package:calendar/constants.dart';
import 'package:calendar/status.dart';
import 'package:flutter/material.dart';

import 'calendar_status.dart';

Widget dayCard(List<List<DateTime?>> matrixDate, DateTime currentDate, int week,
    int day, CalendarStatus calendarStatus) {
  return Padding(
    padding: const EdgeInsets.all(3.5),
    child: Container(
      decoration: BoxDecoration(
          // Если день доступен
          color: (calendarStatus.matrixStatus[currentDate]![week][day] ==
                      Status.avaible ||
                  calendarStatus.matrixStatus[currentDate]![week][day] ==
                      Status.avaibleToday)
              ? Colors.white
              // Если день недоступен
              : (calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.unavaible ||
                      calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.unavaibleToday)
                  ? const Color.fromARGB(175, 214, 214, 214)
                  // День "По умолчанию"
                  : (calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.choosen)
                      ? Colors.black
                      : Colors.transparent,
          border: Border.all(
              color: (calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.avaibleToday ||
                      calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.unavaibleToday ||
                      calendarStatus.matrixStatus[currentDate]![week][day] ==
                          Status.defaultToday)
                  ? Colors.black
                  : Colors.transparent,
              width: 2.5),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          (matrixDate[week][day]?.day.toString() != null)
              ? matrixDate[week][day]!.day.toString()
              : '',
          textAlign: TextAlign.center,
          style: (calendarStatus.matrixStatus[currentDate]![week][day] ==
                      Status.before ||
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
