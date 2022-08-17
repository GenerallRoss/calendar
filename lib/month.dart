import 'package:calendar/constants.dart';
import 'package:calendar/day_card.dart';
import 'package:calendar/calendar_status.dart';
import 'package:calendar/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  // void initShit() async {
  //   Future.delayed(
  //       const Duration(
  //         seconds: 3,
  //       ), () {
  //   });
  // }

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
            Consumer<CalendarStatus>(
              builder:
                  (BuildContext context, CalendarStatus value, Widget? child) {
                return ListView.builder(
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
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 7,
                                child: (value.matrixStatus[widget.currentDate]![
                                            week][day] !=
                                        null)
                                    ? GestureDetector(
                                        onTap: () {
                                          debugPrint(
                                              'Была нажата ${matrixDate[week][day]?.day.toString()} ${months[widget.currentDate.month]} ${widget.currentDate.year}');
                                        },
                                        onDoubleTap: () {
                                          debugPrint(
                                              'Была дважды нажата ${matrixDate[week][day]?.day.toString()} ${months[widget.currentDate.month]} ${widget.currentDate.year}');
                                          //setState(() {
                                          value.addToRange(
                                              matrixDate[week][day],
                                              widget.currentDate,
                                              week,
                                              day);
                                          //});
                                        },
                                        child: dayCard(
                                            matrixDate,
                                            widget.currentDate,
                                            week,
                                            day,
                                            widget.calendarStatus))
                                    : const SizedBox(),
                              );
                            }),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
