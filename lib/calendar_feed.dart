import 'package:bizzy/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logger/logger.dart';

import 'AppState.dart';
import 'EventAction.dart';
import 'EventActionType.dart';

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
              flex: 15,
              child:
                  // Image(
                  //   image: AssetImage('assets/icon/calendar_fill.png'),
                  // ),
                  StoreConnector<AppState, List<Event>>(
                converter: (store) => store.state.events,
                builder: (context, events) {
                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(events[index].title),
                      );
                    },
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                StoreProvider.of<AppState>(context).dispatch(EventAction(
                    EventActionType.create,
                    event: Event("New event action")));
              },
              child: const Text('Press Me'),
            )
          ],
        ));
  }
}
