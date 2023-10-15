import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FinanceCalendarPage extends StatefulWidget {
  const FinanceCalendarPage({super.key});

  @override
  State<FinanceCalendarPage> createState() => _FinanceCalendarPageState();
}

class _FinanceCalendarPageState extends State<FinanceCalendarPage> {
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
