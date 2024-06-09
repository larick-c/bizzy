import 'package:bizzy/event/model/Event.dart';

class FetchEventsByDateRangeSuccessAction {
  final List<Event> listOfEvents;

  FetchEventsByDateRangeSuccessAction({required this.listOfEvents});
}
