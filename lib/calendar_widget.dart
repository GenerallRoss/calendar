import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layouts/month_card.dart';
import 'utils/calendar_service.dart';
import 'values/colors.dart';
import 'values/lists.dart';

Widget calenrarWidget(BuildContext context, [int thisCountMonths = 6]) {
  CalendarService calendarStatus = Provider.of<CalendarService>(context);
  return Scaffold(
    backgroundColor: backgroundColor,
    body: Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: dayList),
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
