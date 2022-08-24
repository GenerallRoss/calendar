import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle dayStyle = TextStyle(
  color: mainGrey,
);

TextStyle monthStyle = const TextStyle(
    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17);

// Текст для прошедших дней
const TextStyle unavaibleTextStyle =
    TextStyle(color: Color.fromARGB(220, 197, 196, 196), fontSize: 20);

// Текст для дней "По умолчанию"
const TextStyle defaultTextStyle = TextStyle(color: Colors.black, fontSize: 20);

const TextStyle choosenTextStyle = TextStyle(color: Colors.white, fontSize: 20);
