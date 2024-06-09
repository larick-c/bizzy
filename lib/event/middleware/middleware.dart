import 'dart:convert';
import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/actions/CreateEventSuccessAction.dart';
import 'package:bizzy/event/actions/EventActionType.dart';
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
    print('Deleted event successfully');
  }).catchError((error) {
    print('Error deleting event: $error');
  });
}

List<Event> parseEvents(String jsonString) {
  final decoded = json.decode(jsonString);
  final data = decoded['data'] as Map<String, dynamic>?;
  if (data == null) {
    throw Exception('Data is null');
  }
  final getEvents = data['getEvents'] as List<dynamic>?;
  if (getEvents == null) {
    throw Exception('getEvents is null');
  }
  return getEvents.map<Event>((json) => Event.fromJson(json)).toList();
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
