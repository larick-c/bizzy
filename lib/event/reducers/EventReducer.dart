import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/actions/CreateEventSuccessAction.dart';
import 'package:bizzy/event/actions/FetchEventsSuccessAction.dart';
import 'package:bizzy/event/state/EventState.dart';

EventState eventReducer(EventState state, dynamic action) {
  switch (action.runtimeType) {
    case CreateEventSuccessAction:
      return state.copyWith(
        events: [...state.events, action.event],
      );
    default:
      return state;
  }
}
