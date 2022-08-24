import 'package:flutter/material.dart';
import 'text_styles.dart';

List<Widget> dayList = [
  Text('Пн', style: dayStyle),
  Text('Вт', style: dayStyle),
  Text('Ср', style: dayStyle),
  Text('Чт', style: dayStyle),
  Text('Пт', style: dayStyle),
  Text('Сб', style: dayStyle),
  Text('Вс', style: dayStyle)
];

const int countMonths = 6;
const int dayCount = 7;
List<DateTime> dateList = [];
