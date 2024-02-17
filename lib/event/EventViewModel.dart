import 'EventAction.dart';
import 'FetchEventsAction.dart';
import 'Event.dart';
import 'EventActionType.dart';
import 'package:bizzy/AppState.dart';
import 'package:redux/redux.dart';

class EventViewModel {
  final List<Event> events;
  final Function(String) createEvent;
  final Function() fetchEvents;

  EventViewModel(
      {required this.events,
      required this.createEvent,
      required this.fetchEvents});

  static EventViewModel fromStore(Store<AppState> store) {
    return EventViewModel(
        events: store.state.events,
        createEvent: (eventTitle) => store.dispatch(EventAction(
            EventActionType.create,
            event: Event(title: eventTitle))),
        fetchEvents: () => store.dispatch(FetchEventsAction()));
  }
}
