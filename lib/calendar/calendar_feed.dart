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
              flex: 15,
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
                        child: ListView.builder(
                          itemCount: eventViewModel.events.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(eventViewModel.events[index].title),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: _controller,
                              decoration: const InputDecoration(
                                labelText: 'Enter Event Title',
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              String eventTitle = _controller.text;
                              eventViewModel.createEvent(eventTitle);
                            },
                            child: const Text('Create Event'),
                          ),
                          ElevatedButton(
                            onPressed: () => eventViewModel.fetchEvents(),
                            child: const Text('Fetch Events'),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
