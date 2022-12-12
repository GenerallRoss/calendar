import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layouts/month_card.dart';
import 'utils/calendar_service.dart';
import 'values/colors.dart';
import 'values/lists.dart';

/// [calenrarWidget] - виджет для отрисовки этого и последующих месяцев в [Column]
/// В качестве параметра в виджет передаётся целочисленная переменная [thisCountMonths]
/// Она указывает, сколько месяцев необходимо отрисовать (по-умолчанию равна 6)
/// В качестве первого месяца, виджет берёт месяц нынешней даты
///
/// Пример:
/// Если сейчас дата 01.01.2022 и в качестве параметра [thisCountMonths] мы передали 8,
/// то виджет отрисует календарь с января по август 2022 года.
/// ```dart
///   calenrarWidget(8); // Отрисует 8 месяцев
/// ```

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
                children: Configuration.dayList),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                  itemCount: thisCountMonths,
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return MonthCard(
                        currentDate: Configuration.dateList[index],
                        calendarStatus: calendarStatus);
                  })),
            ),
          )
        ],
      ),
    ),
  );
}
