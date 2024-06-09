import 'package:bizzy/event/actions/CreateEventSuccessAction.dart';
import 'package:bizzy/event/actions/FetchEventsByDateRangeSuccessAction.dart';
import 'package:bizzy/event/state/EventState.dart';

EventState eventReducer(EventState state, dynamic action) {
  switch (action.runtimeType) {
    case CreateEventSuccessAction:
      return state.copyWith(
        events: [...state.events, action.event],
      );
    case FetchEventsByDateRangeSuccessAction:
      return state.copyWith(events: [...state.events, ...action.listOfEvents]);
    default:
      return state;
  }
}
