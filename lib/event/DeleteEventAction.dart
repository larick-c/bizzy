import 'package:bizzy/event/EventActionType.dart';
import 'Event.dart';

class DeleteEventAction {
  final EventActionType type;
  final Event event;

  DeleteEventAction(this.type, this.event);
}
