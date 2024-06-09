import 'package:bizzy/event/state/EventState.dart';

class AppState {
  final EventState eventState;

  AppState({required this.eventState});

  factory AppState.initialState() {
    return AppState(eventState: EventState.initial());
  }

  AppState copyWith({EventState? eventState}) {
    return AppState(eventState: eventState ?? this.eventState);
  }
}
