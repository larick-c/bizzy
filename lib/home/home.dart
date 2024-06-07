import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bizzy/AppSyncQueries.dart';
import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/CreateEventSuccessAction.dart';
import 'package:bizzy/event/EventAction.dart';
import 'package:bizzy/event/EventActionType.dart';
import 'package:bizzy/event/Event.dart';
import 'package:bizzy/event/FetchEventsAction.dart';
import 'package:bizzy/calendar/calendar_feed.dart';
import 'package:bizzy/finance/finance_feed.dart';
import 'package:bizzy/fitness/fitness_feed.dart';
import 'package:bizzy/home/home_page.dart';
import 'package:bizzy/main.dart';
import 'package:bizzy/nutrition/nutrition_feed.dart';
import 'package:bizzy/profile/profile_feed.dart';
import 'package:bizzy/social/search_feed.dart';
import 'package:bizzy/time_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/src/response.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';
import 'package:bizzy/BGraph.dart';
import 'package:bizzy/event/FetchEventsSuccessAction.dart';

import '../event/DeleteEventAction.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final Store<AppState> eventStore = Store<AppState>(appReducer,
      initialState: AppState.initialState(), middleware: [fetchMiddleware]);
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: eventStore,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeState(),
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: Colors.white,
              ),
              navigationBarTheme: const NavigationBarThemeData(
                  // height: 20,
                  backgroundColor: Colors.white),
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              iconTheme: const IconThemeData())),
    );
  }
}

class HomeState extends StatefulWidget {
  const HomeState({super.key});

  @override
  State<HomeState> createState() => _HomeState();
}

class _HomeState extends State<HomeState> {
  int currentPageIndex = 0;
  int _selectedIndex = 0;
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(pageName, index) {
    setState(() {
      routeFilter(pageName, index);
    });
  }

  routeFilter(pageName, index) {
    logger.i("callback in $pageName INDEX: $index");
    if (index == 0) {
      currentPageIndex = 5;
    } else if (index == 1) {
      currentPageIndex = 6;
    } else if (index == 2) {
      currentPageIndex = 7;
    }
  }

  setCurrentPageIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  mainCallback(index) {
    pageIndexCallback("main", index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: NavigationBar(
          backgroundColor: Colors.transparent,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          animationDuration: Duration.zero,
          onDestinationSelected: (int index) {
            setState(() {
              mainCallback(index);
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
                icon: ImageIcon(AssetImage('assets/icon/profile.png')),
                label: ""),
            NavigationDestination(
                icon: ImageIcon(AssetImage('assets/icon/time.png')), label: ""),
            NavigationDestination(
                icon: ImageIcon(AssetImage('assets/icon/calendar_fill.png')),
                label: ""),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (index == 5) {
            signOutCurrentUser().then((value) =>
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>
                      const Bizzy(), // Replace with your desired screen
                )));
          } else {
            setState(() {
              currentPageIndex = index;
              if (index < 5) {
                _selectedIndex = index;
              }
            });
          }
        },
        selectedIndex: _selectedIndex,
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        animationDuration: Duration.zero,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage('assets/icon/home_fill.png')),
            icon: ImageIcon(AssetImage('assets/icon/home.png')),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage('assets/icon/search_fill.png')),
            icon: ImageIcon(AssetImage('assets/icon/search.png')),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage('assets/icon/weight_fill.png')),
            icon: ImageIcon(AssetImage('assets/icon/weight.png')),
            label: '',
          ),
          NavigationDestination(
            selectedIcon:
                ImageIcon(AssetImage('assets/icon/nutrition_fill.png')),
            icon: ImageIcon(AssetImage('assets/icon/nutrition.png')),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: ImageIcon(AssetImage('assets/icon/finance_fill.png')),
            icon: ImageIcon(AssetImage('assets/icon/finance.png')),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.exit_to_app),
            label: '',
          ),
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const SearchFeed(),
        const FitnessFeed(),
        const NutritionFeed(),
        const FinanceFeed(),
        const ProfileFeed(),
        const TimeFeed(),
        const CalendarFeed()
      ][currentPageIndex],
    );
  }
}

List<Event> eventReducer(List<Event> eventList, dynamic action) {
  switch (action.runtimeType) {
    case FetchEventsSuccessAction:
      return action.events;
    case CreateEventSuccessAction:
      return [...eventList, action.event];
    default:
      break;
  }
  return eventList;
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    events: eventReducer(state.events, action),
  );
}

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
  print("DATA: ${data.body}");
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
  print("DATA: ${data.body}");
  return data;
}

// Middleware for making an HTTP request
void fetchMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is FetchEventsAction) {
    listEvents(action).then((Response response) {
      List<Event> eventList = parseEvents(response.body);
      store.dispatch(FetchEventsSuccessAction(eventList));
    }).catchError((error) {
      print("LIST EVENTS MIDDLEWARE ACTION ERROR: $error");
    });
  } else if (action is EventAction) {
    if (action.type == EventActionType.create) {
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
  } else if (action is DeleteEventAction) {
    if (action.type == EventActionType.delete) {
      deleteEvent(action).then((Response response) {
        print('Deleted event successfully');
      }).catchError((error) {
        print('Error deleting event: $error');
      });
    }
  }
  // Important: Call the next middleware in the chain
  next(action);
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

Future<void> signOutCurrentUser() async {
  final result = await Amplify.Auth.signOut();
  if (result is CognitoCompleteSignOut) {
    safePrint('Sign out completed successfully');
  } else if (result is CognitoFailedSignOut) {
    safePrint('Error signing user out: ${result.exception.message}');
  }
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
