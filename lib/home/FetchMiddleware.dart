// Middleware for making an HTTP request
import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/actions/DeleteEventAction.dart';
import 'package:bizzy/event/actions/EventAction.dart';
import 'package:bizzy/event/actions/EventActionType.dart';
import 'package:bizzy/event/actions/FetchEventsAction.dart';
import 'package:bizzy/event/actions/FetchEventsByDateRangeAction.dart';
import 'package:bizzy/event/middleware/middleware.dart';
import 'package:redux/redux.dart';

void fetchMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is FetchEventsAction) {
    print("FetchEventsAction");
  } else if (action is FetchEventsByDateRangeAction) {
    print('FETCH EVENTS BY DATE RANGE');
  } else if (action is EventAction) {
    if (action.type == EventActionType.create) {
      handleCreateAction(store, action);
    }
  } else if (action is DeleteEventAction) {
    if (action.type == EventActionType.delete) {
      handleDeleteAction(store, action);
    }
  }
  // Important: Call the next middleware in the chain
  next(action);
}
