import 'package:bizzy/calendar/BizzyCalendar.dart';
import 'package:bizzy/calendar/TableEvents.dart';
import 'package:bizzy/event/EventViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logger/logger.dart';

import '../AppState.dart';

class CalendarFeed extends StatefulWidget {
  const CalendarFeed({super.key});

  @override
  State<CalendarFeed> createState() => _CalendarFeedState();
}

class _CalendarFeedState extends State<CalendarFeed> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // Dispose of the TextEditingController when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Expanded(
              child:
                  // Image(
                  //   image: AssetImage('assets/icon/calendar_fill.png'),
                  // ),
                  StoreConnector<AppState, EventViewModel>(
                converter: (store) => EventViewModel.fromStore(store),
                builder: (context, eventViewModel) {
                  return Column(
                    children: [
                      Expanded(
                        // height: MediaQuery.of(context).size.height * .6,
                        child: TableEventsExample(),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // SingleChildScrollView(
                      //   child: SizedBox(
                      //     height: MediaQuery.of(context).size.height * .1,
                      //     child: ListView.builder(
                      //       itemCount: eventViewModel.events.length,
                      //       itemBuilder: (context, index) {
                      //         // return ListTile(
                      //         //   title: Text(eventViewModel.events[index].title),
                      //         // );
                      //         return DismissableWidget(
                      //             event: eventViewModel.events[index]);
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * .1,
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     // mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       SizedBox(
                      //         width: 200,
                      //         child: TextField(
                      //           controller: _controller,
                      //           decoration: const InputDecoration(
                      //             labelText: 'Enter Event Title',
                      //           ),
                      //         ),
                      //       ),
                      //       const SizedBox(height: 20),
                      //       ElevatedButton(
                      //         onPressed: () {
                      //           if (_controller.text != "") {
                      //             String eventTitle = _controller.text;
                      //             eventViewModel.createEvent(eventTitle);
                      //             _controller.clear();
                      //           }
                      //         },
                      //         child: const Text('Create Event'),
                      //       ),
                      //       ElevatedButton(
                      //         onPressed: () => eventViewModel.fetchEvents(),
                      //         child: const Text('Fetch Events'),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
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
