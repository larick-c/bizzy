// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/EventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:table_calendar/table_calendar.dart';

import '../event/Event.dart';
import 'utils.dart';

class TableEventsExample extends StatefulWidget {
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print('Selected day $selectedDay');
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              // Use `CalendarStyle` to customize the UI
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    right: 1,
                    bottom: 1,
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.black, // Customize this color
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(
                            8.0), // Adjust for rounded corners
                      ),
                      child: Text(
                        '${events.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0, // Customize text size
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
              selectedBuilder: (context, date, events) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/icon/1-02.png'),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${date.day}',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
              todayBuilder: (context, date, events) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icon/1-02.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(
                            0.5), // Adjust opacity here (0.0 - 1.0).
                        BlendMode
                            .dstATop, // This blend mode applies the color as an overlay to the image.
                      ),
                    ),
                    // color: Colors.orange, // Custom color for the focused day
                    shape: BoxShape
                        .rectangle, // Change to BoxShape.circle for circle
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust for rounded corners
                  ),
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white), // Custom text style
                  ),
                );
              },
            ),
          ),
          // const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print(value[index].title),
                        title: Text(value[index].title),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          StoreConnector<AppState, EventViewModel>(
            converter: (store) => EventViewModel.fromStore(store),
            builder: (context, eventViewModel) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Enter Event Title',
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_controller.text != "") {
                          Event event = Event(
                              title: _controller.text,
                              eventDate: DateTime.now());
                          eventViewModel.createEvent(event);
                          _controller.clear();
                          DateTime normalizedDate = DateTime(_selectedDay!.year,
                              _selectedDay!.month, _selectedDay!.day);
                          if (!kEvents.containsKey(normalizedDate)) {
                            kEvents[normalizedDate] = [event];
                          } else {
                            kEvents[normalizedDate]?.add(event);
                          }
                        }
                        _selectedEvents.value = _getEventsForDay(_selectedDay!);
                      },
                      child: const Text('Create Event'),
                    ),
                  ),
                  // Expanded(
                  //   child: ElevatedButton(
                  //     onPressed: () => {},
                  //     child: const Text('Fetch Events'),
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class DismissableWidget extends StatefulWidget {
  final dynamic event;

  DismissableWidget({required this.event});

  @override
  _DismissableWidgetState createState() => _DismissableWidgetState();
}

class _DismissableWidgetState extends State<DismissableWidget> {
  final GlobalKey<_DismissableWidgetState> dismissableKey = GlobalKey();
  bool _isDismissed = false;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EventViewModel>(
        converter: (store) => EventViewModel.fromStore(store),
        builder: (context, eventViewModel) {
          return _isDismissed
              ? SizedBox()
              : Dismissible(
                  key: dismissableKey, // Provide a unique key for each item
                  background: Container(
                      color: Colors.red), // Background color when swiping
                  direction: DismissDirection
                      .endToStart, // Swipe from right to left to delete
                  onDismissed: (direction) {
                    setState(() {
                      _isDismissed = true;
                    });
                    eventViewModel.deleteEvent(widget.event);
                  },
                  child: ListTile(
                    title: Text(widget.event.title),
                    trailing: const Icon(Icons.delete), // Delete icon
                  ),
                );
        });
  }
}
