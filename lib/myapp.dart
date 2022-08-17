import 'package:calendar/constants.dart';
import 'package:calendar/calendar_status.dart';
import 'package:calendar/month.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CalendarStatus(),
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
  List<DateTime> dateList = [];

  @override
  void initState() {
    for (int index = 0; index < countMonths; index++) {
      dateList.add(DateTime(currentDate.year, currentDate.month + index));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                    itemCount: countMonths,
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
}
