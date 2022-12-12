import 'package:calendar/calendar_widget.dart';
import 'package:calendar/values/lists.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/calendar_service.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    for (int index = 0; index < Configuration.countMonths; index++) {
      Configuration.dateList
          .add(DateTime(currentDate.year, currentDate.month + index));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return calenrarWidget(context, Configuration.countMonths);
  }
}
