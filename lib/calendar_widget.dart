import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layouts/month.dart';
import 'utils/calendar_status.dart';
import 'values/constants.dart';

Widget calenrarWidget(BuildContext context, [int thisCountMonths = 6]) {
  CalendarStatus calendarStatus = Provider.of<CalendarStatus>(context);
  return Scaffold(
    backgroundColor: backgroundColor,
    body: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Пн', style: dayStyle),
                  Text('Вт', style: dayStyle),
                  Text('Ср', style: dayStyle),
                  Text('Чт', style: dayStyle),
                  Text('Пт', style: dayStyle),
                  Text('Сб', style: dayStyle),
                  Text('Вс', style: dayStyle),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: thisCountMonths,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return MonthCard(
                        currentDate: dateList[index],
                        calendarStatus: calendarStatus);
                  })),
            ),
          )
        ],
      ),
    ),
  );
}
