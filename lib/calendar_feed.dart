import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarFeed extends StatefulWidget {
  const CalendarFeed({super.key});

  @override
  State<CalendarFeed> createState() => _CalendarFeedState();
}

class _CalendarFeedState extends State<CalendarFeed> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              child: TableCalendar(focusedDay: DateTime.now(), firstDay: DateTime(2023, 1,1), lastDay: DateTime.now())
            ),
          ],
        ));
  }
}
