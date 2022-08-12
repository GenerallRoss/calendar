import 'package:flutter/material.dart';

Color mainGrey = const Color.fromARGB(255, 172, 171, 171);
Color backgroundColor = const Color.fromARGB(255, 241, 241, 241);

TextStyle dayStyle = TextStyle(
  color: mainGrey,
);

TextStyle monthStyle = const TextStyle(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17);

const int countMonths = 6;

const Map<int, String> months = {
  1: 'Январь',
  2: 'Февраль',
  3: 'Март',
  4: 'Апрель',
  5: 'Май',
  6: 'Июнь',
  7: 'Июль',
  8: 'Август',
  9: 'Сентябрь',
  10: 'Октябрь',
  11: 'Ноябрь',
  12: 'Декабрь'
};
