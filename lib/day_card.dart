// ignore_for_file: unrelated_type_equality_checks

import 'package:calendar/constants.dart';
import 'package:calendar/status.dart';
import 'package:flutter/material.dart';

import 'matrix_mobx.dart';

Widget dayCard(
    List<List<DateTime?>> matrixDate, DateTime currentDate, int week, int day) {
  return Padding(
    padding: const EdgeInsets.all(3.5),
    child: Container(
      decoration: BoxDecoration(
          // Если день доступен
          color: (matrixStatus[currentDate]![week][day] == Status.avaible ||
                  matrixStatus[currentDate]![week][day] == Status.avaibleToday)
              ? Colors.white
              // Если день недоступен
              : (matrixStatus[currentDate]![week][day] == Status.unavaible ||
                      matrixStatus[currentDate]![week][day] ==
                          Status.unavaibleToday)
                  ? const Color.fromARGB(175, 214, 214, 214)
                  // День "По умолчанию"
                  : (matrixStatus[currentDate]![week][day] == Status.choosen)
                      ? Colors.black
                      : Colors.transparent,
          border: Border.all(
              color: (matrixStatus[currentDate]![week][day] ==
                          Status.avaibleToday ||
                      matrixStatus[currentDate]![week][day] ==
                          Status.unavaibleToday ||
                      matrixStatus[currentDate]![week][day] ==
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
          style: (matrixStatus[currentDate]![week][day] == Status.before ||
                  matrixStatus[currentDate]![week][day] == Status.unavaible ||
                  matrixStatus[currentDate]![week][day] ==
                      Status.unavaibleToday)
              ? unavaibleTextStyle
              : (matrixStatus[currentDate]![week][day] == Status.choosen)
                  ? choosenTextStyle
                  : defaultTextStyle,
        ),
      ),
    ),
  );
}
