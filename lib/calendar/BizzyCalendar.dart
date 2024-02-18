import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

class BizzyCalendar extends StatelessWidget {
  const BizzyCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: BizzyCalendarPage(),
      ),
    );
  }
}

class BizzyCalendarPage extends StatefulWidget {
  const BizzyCalendarPage({super.key});

  @override
  _BizzyCalendarPage createState() => _BizzyCalendarPage();
}

class _BizzyCalendarPage extends State<BizzyCalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2021, 01, 01),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.
            return isSameDay(_selectedDay, day);
          },
        ),
      ],
    );
  }
}
