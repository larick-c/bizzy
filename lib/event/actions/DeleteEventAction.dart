import 'package:bizzy/event/actions/EventActionType.dart';
import '../model/Event.dart';

class DeleteEventAction {
  final EventActionType type;
  final Event event;

  DeleteEventAction(this.type, this.event);
}
