import 'package:bizzy/event/EventWithId.dart';

class AppState {
  final List<EventWithId> events;

  AppState({required this.events});

  factory AppState.initialState() {
    return AppState(events: []);
  }

  AppState copyWith({List<EventWithId>? events}) {
    return AppState(events: events ?? this.events);
  }

  @override
  String toString() {
    return 'EventState{events: $events}';
  }
}
