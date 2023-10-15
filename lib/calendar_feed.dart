import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
        child: const Column(
          children: <Widget>[
            Expanded(
              flex: 15,
              child: Image(
                image: AssetImage('assets/icon/calendar_fill.png'),
              ),
            ),
          ],
        ));
  }
}
