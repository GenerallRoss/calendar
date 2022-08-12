import 'package:calendar/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthCard extends StatefulWidget {
  const MonthCard({Key? key, required this.dateTime}) : super(key: key);

  final DateTime dateTime;

  @override
  State<MonthCard> createState() => _MonthCardState();
}

class _MonthCardState extends State<MonthCard> {
  int getWeeks(DateTime currentDate) {
    var days = DateUtils.getDaysInMonth(currentDate.year, currentDate.month);
    int result = 1;
    for (int i = 2; i < days + 1; i++) {
      if (DateFormat('EEEE')
              .format(DateTime(currentDate.year, currentDate.month, i)) ==
          'Monday') {
        result += 1;
      }
    }
    return result;
  }

  List<List<int>> getMonthMatrix(DateTime currentDate) {
    List<List<int>> matrix = [];
    int weeks = getWeeks(currentDate);
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
      matrix.add([0, 0, 0, 0, 0, 0, 0]);
      for (int n = 0; n < 7; n++) {
        if (i == 0 && index == 1) {
          var day1 = days[n];
          var day2 = DateFormat('EEEE').format(
              DateTime(currentDate.year, currentDate.month, currentDate.day));
          if (day1 == day2) {
            matrix[i][n] = index;
            index++;
          }
        } else if (index <=
            DateUtils.getDaysInMonth(currentDate.year, currentDate.month)) {
          matrix[i][n] = index;
          index++;
        }
      }
    }
    return matrix;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Text(
              "${months[widget.dateTime.month]} ${widget.dateTime.year}",
              style: monthStyle,
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                  itemCount: getWeeks(widget.dateTime),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ListView.builder(
                          itemCount: 7,
                          primary: false,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index2) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(7),
                                  // border: const Border(
                                  //     top: BorderSide(color: Colors.black))
                                ),
                                child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      (getMonthMatrix(widget.dateTime)[index]
                                                      [index2]
                                                  .toString() !=
                                              '0')
                                          ? getMonthMatrix(widget.dateTime)[
                                                  index][index2]
                                              .toString()
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )),
                              ),
                            );
                          }),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
