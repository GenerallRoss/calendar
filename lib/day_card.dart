// ignore_for_file: unrelated_type_equality_checks

import 'package:calendar/constants.dart';
import 'package:calendar/status.dart';
import 'package:flutter/material.dart';

Widget dayCard(
    List<List<DateTime?>> matrixDate, DateTime currentDate, int week, int day) {
  return Padding(
    padding: const EdgeInsets.all(3.5),
    child: Container(
      decoration: BoxDecoration(
          // Если день доступен
          color: (matrix.matrixStatus[currentDate]![week][day] ==
                      Status.avaible ||
                  matrix.matrixStatus[currentDate]![week][day] ==
                      Status.avaibleToday)
              ? Colors.white
              // Если день недоступен
              : (matrix.matrixStatus[currentDate]![week][day] ==
                          Status.unavaible ||
                      matrix.matrixStatus[currentDate]![week][day] ==
                          Status.unavaibleToday)
                  ? const Color.fromARGB(175, 214, 214, 214)
                  // День "По умолчанию"
                  : (matrix.matrixStatus[currentDate]![week][day] ==
                          Status.choosen)
                      ? Colors.black
                      : Colors.transparent,
          border: Border.all(
              color: (matrix.matrixStatus[currentDate]![week][day] ==
                          Status.avaibleToday ||
                      matrix.matrixStatus[currentDate]![week][day] ==
                          Status.unavaibleToday ||
                      matrix.matrixStatus[currentDate]![week][day] ==
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
          style: (matrix.matrixStatus[currentDate]![week][day] ==
                      Status.before ||
                  matrix.matrixStatus[currentDate]![week][day] ==
                      Status.unavaible ||
                  matrix.matrixStatus[currentDate]![week][day] ==
                      Status.unavaibleToday)
              ? unavaibleTextStyle
              : (matrix.matrixStatus[currentDate]![week][day] == Status.choosen)
                  ? choosenTextStyle
                  : defaultTextStyle,
        ),
      ),
    ),
  );
}
