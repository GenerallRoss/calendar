import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import '../utils/calendar_status.dart';
import '../utils/functions.dart';
import '../values/constants.dart';
import '../values/status.dart';
import 'day_card.dart';

class MonthCard extends StatefulWidget {
  const MonthCard(
      {Key? key, required this.currentDate, required this.calendarStatus})
      : super(key: key);

  final DateTime currentDate;
  final CalendarStatus calendarStatus;

  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {
  List<List<DateTime?>> matrixDate = [];

  @override
  void initState() {
    super.initState();
    matrixDate = getMonthMatrix(widget.currentDate);
    widget.calendarStatus.initMatrixStatus(matrixDate);
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    DateFormat dateMonth = DateFormat.yMMMM('ru');
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Text(
              dateMonth.format(widget.currentDate),
              style: monthStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            Consumer<CalendarStatus>(
              builder:
                  (BuildContext context, CalendarStatus value, Widget? child) {
                return LayoutBuilder(builder: (context2, boxConstraints) {
                  return ListView.builder(
                      itemCount: getCountWeeks(widget.currentDate),
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context3, week) {
                        return SizedBox(
                          height: 45,
                          child: ListView.builder(
                              itemCount: dayCount,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, day) {
                                return SizedBox(
                                  width: boxConstraints.maxWidth / dayCount,
                                  child: (value.matrixStatus[
                                              widget.currentDate]![week][day] !=
                                          null)
                                      ? GestureDetector(
                                          onTap: () {
                                            if (value.matrixStatus[widget
                                                    .currentDate]![week][day] !=
                                                Status.unavaible) {
                                              value.selectDate(
                                                  matrixDate[week][day]!);
                                            }
                                          },
                                          child: dayCard(
                                              matrixDate,
                                              widget.currentDate,
                                              week,
                                              day,
                                              value))
                                      : const SizedBox(),
                                );
                              }),
                        );
                      });
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
