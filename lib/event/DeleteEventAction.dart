import 'package:bizzy/event/EventActionType.dart';
import 'EventWithId.dart';

class DeleteEventAction {
  final EventActionType type;
  final EventWithId eventWithId;

  DeleteEventAction(this.type, this.eventWithId);
}
