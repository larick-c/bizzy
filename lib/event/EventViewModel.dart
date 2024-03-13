import 'package:bizzy/event/DeleteEventAction.dart';
import 'package:bizzy/event/EventWithId.dart';

import 'EventAction.dart';
import 'FetchEventsAction.dart';
import 'Event.dart';
import 'EventActionType.dart';
import 'package:bizzy/AppState.dart';
import 'package:redux/redux.dart';

class EventViewModel {
  final List<EventWithId> events;
  final Function(Event) createEvent;
  final Function(EventWithId) deleteEvent;
  final Function() fetchEvents;

  EventViewModel(
      {required this.events,
      required this.createEvent,
      required this.deleteEvent,
      required this.fetchEvents});

  static EventViewModel fromStore(Store<AppState> store) {
    return EventViewModel(
        events: store.state.events,
        createEvent: (event) =>
            store.dispatch(EventAction(EventActionType.create, event: event)),
        deleteEvent: (event) =>
            store.dispatch(DeleteEventAction(EventActionType.delete, event)),
        fetchEvents: () => store.dispatch(FetchEventsAction()));
  }
}
