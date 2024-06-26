import 'package:bizzy/event/actions/DeleteEventAction.dart';
import '../actions/EventAction.dart';
import '../actions/FetchEventsAction.dart';
import 'Event.dart';
import '../actions/EventActionType.dart';
import 'package:bizzy/AppState.dart';
import 'package:redux/redux.dart';

class EventViewModel {
  final List<Event> events;
  final Function(Event) createEvent;
  final Function(Event) deleteEvent;
  final Function() fetchEvents;

  EventViewModel(
      {required this.events,
      required this.createEvent,
      required this.deleteEvent,
      required this.fetchEvents});

  static EventViewModel fromStore(Store<AppState> store) {
    return EventViewModel(
      events: store.state.eventState.events,
      createEvent: (event) =>
          store.dispatch(EventAction(EventActionType.create, event: event)),
      deleteEvent: (event) =>
          store.dispatch(DeleteEventAction(EventActionType.delete, event)),
      fetchEvents: () => store.dispatch(FetchEventsAction()),
      // selectEventsForDateRange:
    );
  }
}
