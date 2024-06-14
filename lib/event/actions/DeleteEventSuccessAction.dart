import 'package:bizzy/event/actions/EventActionType.dart';
import '../model/Event.dart';

class DeleteEventSuccessAction {
  final EventActionType type;
  final Event event;

  DeleteEventSuccessAction(this.type, this.event);
}
