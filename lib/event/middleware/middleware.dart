import 'dart:convert';
import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/actions/CreateEventSuccessAction.dart';
import 'package:bizzy/event/actions/DeleteEventSuccessAction.dart';
import 'package:bizzy/event/actions/EventActionType.dart';
import 'package:bizzy/event/actions/FetchEventsByDateRangeSuccessAction.dart';
import 'package:bizzy/event/model/Event.dart';
import 'package:bizzy/event/queries/api.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';

Future<void> handleCreateAction(Store<AppState> store, dynamic action) async {
  createEvent(action).then((Response response) {
    Map<String, dynamic> responseHandler = handleGraphQLResponse(response);
    if (responseHandler['errors'] != null &&
        responseHandler['errors'].length > 0) {
      print('ResponseHandler is not empty');
    } else {
      print('Created event successfully');
      Event event = Event.fromMap(responseHandler['createEvent']);
      store.dispatch(CreateEventSuccessAction(event));
    }
  }).catchError((error) {
    print('Error creating event: $error');
  });
}

Future<void> handleDeleteAction(Store<AppState> store, dynamic action) async {
  deleteEvent(action).then((Response response) {
    Event event = graphQLResponseHandler(store, response, 'deleteEvent');
    store.dispatch(DeleteEventSuccessAction(EventActionType.delete, event));
  }).catchError((error) {
    print('Error deleting event: $error');
  });
}

Future<void> handleFetchEventsByDateRangeAction(
    Store<AppState> store, dynamic action) async {
  fetchEventsByDateRange(action).then((Response response) {
    handleGraphQLResponse(response);
    List<Event> plusMinusOneMonthListOfEvents =
        parseEvents(response.body, 'getEventsByDate');
    store.dispatch(FetchEventsByDateRangeSuccessAction(
        listOfEvents: plusMinusOneMonthListOfEvents));
    print('got events by date range successfully');
    print('found (${plusMinusOneMonthListOfEvents.length}) events');
  }).catchError((onError) {
    print('Error fetching events by date range: $onError');
  });
}

Event graphQLResponseHandler(
    Store<AppState> store, Response response, String method) {
  Map<String, dynamic> responseHandler = handleGraphQLResponse(response);
  if (responseHandler['errors'] != null &&
      responseHandler['errors'].length > 0) {
    throw Exception(
        'ERROR in graphQLResponseHandler: ${responseHandler['errors']}');
  } else {
    return Event.fromMap(responseHandler[method]);
  }
}

List<Event> parseEvents(String jsonString, method) {
  final decoded = json.decode(jsonString);
  final data = decoded['data'] as Map<String, dynamic>?;
  if (data == null) {
    throw Exception('Data is null');
  }
  final getEvents = data[method] as List<dynamic>?;
  if (getEvents == null) {
    throw Exception('getEvents is null');
  }
  return getEvents.map<Event>((json) => Event.fromMap(json)).toList();
}

Map<String, dynamic> handleGraphQLResponse(Response response) {
  Map<String, dynamic> responseData = jsonDecode(response.body);
  if (response.statusCode == 200) {
    // Successful response, parse JSON
    // Check if there are any errors
    if (responseData.containsKey('errors')) {
      List<dynamic> errors = responseData['errors'];
      // Extract error messages
      List errorMessages = errors.map((error) => error['message']).toList();

      // Print or handle error messages
      if (errorMessages.isNotEmpty) {
        throw Exception("Error: $errorMessages");
      }
      return responseData;
    } else {
      // No errors, process data
      print('GraphQL Data: ${responseData['data']}');
      return responseData['data'];
    }
  } else {
    // Handle non-200 status code
    print('HTTP Error: ${response.statusCode}');
    print('HTTP Error: ${responseData['errors'][0]['errorType']}');
    print('HTTP Error: ${responseData['errors'][0]['message']}');
    return responseData;
  }
}
