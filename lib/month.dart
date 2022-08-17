import 'package:calendar/constants.dart';
import 'package:calendar/day_card.dart';
import 'package:calendar/matrix_mobx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class MonthCard extends StatefulWidget {
  const MonthCard({Key? key, required this.currentDate}) : super(key: key);

  final DateTime currentDate;

  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {
  List<List<DateTime?>> matrixDate = [];

  int getWeeks(DateTime date) {
    var days = DateUtils.getDaysInMonth(date.year, date.month);
    int result = 1;
    for (int i = 2; i < days + 1; i++) {
      if (DateFormat('EEEE').format(DateTime(date.year, date.month, i)) ==
          'Monday') {
        result += 1;
      }
    }
    return result;
  }

  List<List<DateTime?>> getMonthMatrix(DateTime date) {
    List<List<DateTime?>> matrix = [];
    int weeks = getWeeks(date);
    int index = 1;
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    for (int i = 0; i < weeks; i++) {
      matrix.add([null, null, null, null, null, null, null]);
      for (int n = 0; n < 7; n++) {
        if (i == 0 && index == 1) {
          var day1 = days[n];
          var day2 = DateFormat('EEEE')
              .format(DateTime(date.year, date.month, date.day));
          if (day1 == day2) {
            matrix[i][n] = DateTime(date.year, date.month, index);
            index++;
          }
        } else if (index <= DateUtils.getDaysInMonth(date.year, date.month)) {
          matrix[i][n] = DateTime(date.year, date.month, index);
          index++;
        }
      }
    }
    return matrix;
  }

  @override
  void initState() {
    matrixDate = getMonthMatrix(widget.currentDate);
    matrixStatus[widget.currentDate] = initMatrixStatus(matrixDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              "${months[widget.currentDate.month]} ${widget.currentDate.year}",
              style: monthStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            ListView.builder(
                itemCount: getWeeks(widget.currentDate),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, week) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: ListView.builder(
                        itemCount: 7,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, day) {
                          return Observer(
                            builder: (_) => SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: (matrixStatus[widget.currentDate]![week]
                                          [day] !=
                                      null)
                                  ? GestureDetector(
                                      onTap: () {
                                        debugPrint(
                                            'Была нажата ${matrixDate[week][day]?.day.toString()} ${months[widget.currentDate.month]} ${widget.currentDate.year}');
                                      },
                                      onDoubleTap: () {
                                        debugPrint(
                                            'Была дважды нажата ${matrixDate[week][day]?.day.toString()} ${months[widget.currentDate.month]} ${widget.currentDate.year}');
                                        addToRange(matrixDate[week][day],
                                            widget.currentDate, week, day);
                                      },
                                      child: dayCard(matrixDate,
                                          widget.currentDate, week, day))
                                  : const SizedBox(),
                            ),
                          );
                        }),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
