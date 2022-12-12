import 'package:flutter/material.dart';
import 'text_styles.dart';

class Configuration {
  static List<Widget> dayList = [
    Text('Пн', style: dayStyle),
    Text('Вт', style: dayStyle),
    Text('Ср', style: dayStyle),
    Text('Чт', style: dayStyle),
    Text('Пт', style: dayStyle),
    Text('Сб', style: dayStyle),
    Text('Вс', style: dayStyle)
  ];

  static int countMonths = 6;
  static int dayCount = 7;

  static List<DateTime> dateList = [];
}
