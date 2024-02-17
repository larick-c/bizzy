import 'EventActionType.dart';
import 'Event.dart';

class EventAction {
  final EventActionType type;
  final Event? event;

  EventAction(this.type, {this.event});
}
