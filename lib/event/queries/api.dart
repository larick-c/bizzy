import 'package:bizzy/BGraph.dart';
import 'package:bizzy/event/queries/AppSyncQueries.dart';
import 'package:http/http.dart';

Future<Response> createEvent(dynamic action) async {
  Map<String, dynamic> eventInput = {
    "input": {
      "userId": action.event.userId,
      "title": action.event.title,
      "date": action.event.date.toString()
    }
  };
  final data =
      await BGraph.query(AppSyncQueries.createEvent, variables: eventInput);
  return data;
}

Future<Response> listEvents(dynamic action) async {
  final data = await BGraph.listEvents(AppSyncQueries.listEvents);
  return data;
}

Future<Response> fetchEventsByDateRange(dynamic action) async {
  Map<String, dynamic> eventDateRangeInput = {
    "input": {
      "userId": action.userId,
      "startDate": action.startDate.toString(),
      "endDate": action.endDate.toString()
    }
  };
  final data = await BGraph.query(AppSyncQueries.getEventsByDateRange,
      variables: eventDateRangeInput);
  return data;
}

Future<Response> deleteEvent(dynamic action) async {
  Map<String, dynamic> deleteEventInput = {
    "input": {
      "userId": action.event.userId,
      "eventId": action.event.eventId,
      "date": action.event.date.toString()
    }
  };
  final data = await BGraph.query(AppSyncQueries.deleteEvent,
      variables: deleteEventInput);
  return data;
}
