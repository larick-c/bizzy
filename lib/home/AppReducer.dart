import 'package:bizzy/AppState.dart';
import 'package:redux/redux.dart';

// Assuming you have other reducers like userReducer and counterReducer
import '../event/reducers/EventReducer.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, dynamic>(eventReducerWrapper),
]);

AppState eventReducerWrapper(AppState state, dynamic action) {
  final updatedEventState = eventReducer(state.eventState, action);
  return state.copyWith(eventState: updatedEventState);
}
