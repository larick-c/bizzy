import 'EventActionType.dart';
import '../model/Event.dart';

class EventAction {
  final EventActionType type;
  final Event? event;

  EventAction(this.type, {this.event});
}
