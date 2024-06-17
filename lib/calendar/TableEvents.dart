// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/actions/DeleteEventAction.dart';
import 'package:bizzy/event/actions/EventActionType.dart';
import 'package:bizzy/event/model/EventViewModel.dart';
import 'package:bizzy/event/actions/FetchEventsByDateRangeAction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:table_calendar/table_calendar.dart';

import '../event/model/Event.dart';
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
  late AuthUser user;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    try {
      user = await Amplify.Auth.getCurrentUser();
      // Access the Redux store in initState
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final store = StoreProvider.of<AppState>(context);
        store.dispatch(FetchEventsByDateRangeAction(
            userId: user.userId,
            startDate: _focusedDay.subtract(const Duration(days: 30)),
            endDate: _focusedDay.add(const Duration(days: 30))));
        // Perform any actions or initial state setup
        // print("Initial counter value: ${store.events?.length}");
      });
    } catch (error) {
      print('ERROR: ${error.toString()}');
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
    // return eventsByDate[day] ?? [];
  }

  List<Event> _selectEventsForDay(List<Event> events, DateTime? day) {
    List<Event> updatedEvents = [];
    for (var event in events) {
      if (event.date?.year == day?.year &&
          event.date?.month == day?.month &&
          event.date?.day == day?.day) {
        updatedEvents.add(event);
      }
    }
    return updatedEvents.isNotEmpty ? updatedEvents : [];
  }

  int? _selectEventCountForDay(List<Event> events, DateTime? day) {
    int count = 0;
    for (var event in events) {
      if (event.date?.year == day?.year &&
          event.date?.month == day?.month &&
          event.date?.day == day?.day) {
        count++;
      }
    }
    return count;
  }

  // List<Event> _selectEventsForRange(DateTime start, DateTime end) {}

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

      // _selectedEvents.value = _getEventsForDay(selectedDay);
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

// Transform the list of events into the required Map<DateTime, List<Event>> format
  Map<DateTime, List<Event>> groupEventsByDate(List<Event> events) {
    Map<DateTime, List<Event>> groupedEvents = {};

    for (var event in events) {
      final eventDate =
          DateTime(event.date!.year, event.date!.month, event.date!.day);
      if (groupedEvents[eventDate] == null) {
        groupedEvents[eventDate] = [];
      }
      groupedEvents[eventDate]!.add(event);
    }

    return groupedEvents;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, EventViewModel>(
        converter: (store) => EventViewModel.fromStore(store),
        builder: (context, eventViewModel) {
          final eventsByDate = groupEventsByDate(eventViewModel.events);
          return Scaffold(
            body: Column(children: [
              TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: (day) {
                  DateTime normalizedDate =
                      DateTime(day.year, day.month, day.day);
                  return eventsByDate[normalizedDate] ?? [];
                },
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
                        style:
                            TextStyle(color: Colors.white), // Custom text style
                      ),
                    );
                  },
                ),
              ),
              // const SizedBox(height: 8.0),
              Expanded(
                child: ListView.builder(
                  itemCount: _selectEventCountForDay(
                      eventViewModel.events, _selectedDay),
                  itemBuilder: (context, index) {
                    return DismissibleExample(
                        event: eventViewModel.events[index]);
                  },
                ),
              ),
              Row(
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
                      onPressed: () async {
                        if (_controller.text != "") {
                          Event event = Event(
                              userId: user.userId,
                              title: _controller.text,
                              date: _selectedDay);
                          eventViewModel.createEvent(event);
                          _controller.clear();
                        }
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
              ),
            ]),
          );
        });
  }
}

class DismissibleExample extends StatefulWidget {
  const DismissibleExample({super.key, required this.event});
  final Event event;
  @override
  _DismissibleExampleState createState() => _DismissibleExampleState();
}

class _DismissibleExampleState extends State<DismissibleExample> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      background: Container(
        color: Colors.red,
      ),
      key: ValueKey<String?>(widget.event.eventId),
      onDismissed: (DismissDirection direction) {
        StoreProvider.of<AppState>(context)
            .dispatch(DeleteEventAction(EventActionType.delete, widget.event));
      },
      child: ListTile(
        title: Text(widget.event.title,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 3)),
        subtitle: Text('${widget.event.date}'),
        leading: const Icon(Icons.event, color: Colors.black),
        trailing: const Icon(
          Icons.remove,
          color: Colors.black,
        ),
      ),
    );
  }
}

Future<AuthUser?> getCurrentUser() async {
  try {
    return await Amplify.Auth.getCurrentUser();
  } catch (e) {
    print('Error getting current user: $e');
    return null;
  }
}
