import 'package:bizzy/event/Event.dart';

class AppState {
  final List<Event> events;

  AppState({required this.events});

  factory AppState.initialState() {
    return AppState(events: []);
  }

  AppState copyWith({List<Event>? events}) {
    return AppState(events: events ?? this.events);
  }

  @override
  String toString() {
    return 'EventState{events: $events}';
  }
}
