import 'package:flutter/material.dart';

Color mainGrey = const Color.fromARGB(255, 172, 171, 171);
Color backgroundColor = const Color.fromARGB(255, 241, 241, 241);
Color unuvaibleDayColor = const Color.fromARGB(175, 214, 214, 214);
Color rangedColor = const Color.fromARGB(171, 202, 202, 202);

TextStyle dayStyle = TextStyle(
  color: mainGrey,
);

TextStyle monthStyle = const TextStyle(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17);

const int countMonths = 6;
int dayCount = 7;
List<DateTime> dateList = [];

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

// Стиль для текста без фона и обводки
BoxDecoration defaultDecoration = BoxDecoration(
    color: Colors.transparent,
    border: Border.all(width: 0, color: Colors.transparent));

BoxDecoration todayDecoration = BoxDecoration(
  color: Colors.transparent,
  border: Border.all(
    color: Colors.black,
    width: 3,
  ),
  borderRadius: BorderRadius.circular(10),
);

BoxDecoration avaibleDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(
    color: Colors.transparent,
    width: 3,
  ),
  borderRadius: BorderRadius.circular(10),
);

// Текст для прошедших дней
const TextStyle unavaibleTextStyle =
    TextStyle(color: Color.fromARGB(220, 197, 196, 196), fontSize: 20);

// Текст для дней "По умолчанию"
const TextStyle defaultTextStyle = TextStyle(color: Colors.black, fontSize: 20);

const TextStyle choosenTextStyle = TextStyle(color: Colors.white, fontSize: 20);
