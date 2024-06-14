import 'package:bizzy/event/actions/CreateEventSuccessAction.dart';
import 'package:bizzy/event/actions/DeleteEventSuccessAction.dart';
import 'package:bizzy/event/actions/FetchEventsByDateRangeSuccessAction.dart';
import 'package:bizzy/event/model/Event.dart';
import 'package:bizzy/event/state/EventState.dart';

EventState eventReducer(EventState state, dynamic action) {
  switch (action.runtimeType) {
    case CreateEventSuccessAction:
      return state.copyWith(
        events: [...state.events, action.event],
      );
    case FetchEventsByDateRangeSuccessAction:
      return state.copyWith(events: [...state.events, ...action.listOfEvents]);
    case DeleteEventSuccessAction:
      List<Event> updatedList = [];
      for (Event event in state.events) {
        if (event.eventId != action.event.eventId) {
          updatedList.add(event);
        }
      }
      return state.copyWith(events: updatedList);
    default:
      return state;
  }
}
