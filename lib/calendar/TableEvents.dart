// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bizzy/AppState.dart';
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

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    try {
      // Access the Redux store in initState
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final store = StoreProvider.of<AppState>(context);
        store.dispatch(FetchEventsByDateRangeAction(
            startDate: _focusedDay.subtract(const Duration(days: 30)),
            endDate: _focusedDay.add(const Duration(days: 30))));
        // Perform any actions or initial state setup
        // print("Initial counter value: ${store.events?.length}");
      });
    } catch (error) {
      print('ERROR: ${error.toString()}');
    }
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
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

  Event? _selectEventsForDay(
      EventViewModel viewModel, DateTime? day, int index) {
    List<Event> events = [];
    for (var event in viewModel.events) {
      if (event.date?.year == day?.year &&
          event.date?.month == day?.month &&
          event.date?.day == day?.day) {
        events.add(event);
      }
    }
    return events.isNotEmpty ? events[index] : null;
  }

  int? _selectEventCountForDay(EventViewModel viewModel, DateTime? day) {
    int count = 0;
    for (var event in viewModel.events) {
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
            child: StoreConnector<AppState, EventViewModel>(
              converter: (store) => EventViewModel.fromStore(store),
              builder: (context, eventViewModel) {
                return ListView.builder(
                  itemCount:
                      _selectEventCountForDay(eventViewModel, _selectedDay),
                  itemBuilder: (context, index) {
                    return DismissableWidget(
                        event: _selectEventsForDay(
                            eventViewModel, _selectedDay, index));
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
                      onPressed: () async {
                        if (_controller.text != "") {
                          AuthUser user = await Amplify.Auth.getCurrentUser();
                          Event event = Event(
                              userId: user.userId,
                              title: _controller.text,
                              date: _selectedDay);
                          eventViewModel.createEvent(event);
                          _controller.clear();
                          DateTime normalizedDate = DateTime(_selectedDay!.year,
                              _selectedDay!.month, _selectedDay!.day);
                          if (!kEvents.containsKey(normalizedDate)) {
                            kEvents[normalizedDate] = [event];
                          } else {
                            kEvents[normalizedDate]?.add(event);
                          }
                          print("Date: $normalizedDate");
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

Future<AuthUser?> getCurrentUser() async {
  try {
    return await Amplify.Auth.getCurrentUser();
  } catch (e) {
    print('Error getting current user: $e');
    return null;
  }
}
