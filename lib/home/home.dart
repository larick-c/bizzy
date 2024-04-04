import 'dart:convert';

import 'package:bizzy/AppSyncQueries.dart';
import 'package:bizzy/AppState.dart';
import 'package:bizzy/event/EventAction.dart';
import 'package:bizzy/event/EventActionType.dart';
import 'package:bizzy/event/EventWithId.dart';
import 'package:bizzy/event/FetchEventsAction.dart';
import 'package:bizzy/calendar/calendar_feed.dart';
import 'package:bizzy/finance/finance_feed.dart';
import 'package:bizzy/fitness/fitness_feed.dart';
import 'package:bizzy/home/home_page.dart';
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
          setState(() {
            currentPageIndex = index;
            if (index < 5) {
              _selectedIndex = index;
            }
          });
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

List<EventWithId> eventReducer(List<EventWithId> eventList, dynamic action) {
  switch (action.runtimeType) {
    case FetchEventsSuccessAction:
      return action.events;
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
      "title": action.event.title,
      "eventDate": action.event.eventDate.toString()
    }
  };
  final data = await BGraph.createEvent(AppSyncQueries.createEvent,
      variables: eventInput);
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
      "userId": action.eventWithId.userId,
      "created_ts": action.eventWithId.created_ts
    }
  };
  final data = await BGraph.createEvent(AppSyncQueries.deleteEvent,
      variables: deleteEventInput);
  print("DATA: ${data.body}");
  return data;
}

// Middleware for making an HTTP request
void fetchMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is FetchEventsAction) {
    listEvents(action).then((Response response) {
      List<EventWithId> eventList = parseEvents(response.body);
      store.dispatch(FetchEventsSuccessAction(eventList));
    }).catchError((error) {
      print("LIST EVENTS MIDDLEWARE ACTION ERROR: $error");
    });
  } else if (action is EventAction) {
    if (action.type == EventActionType.create) {
      print('Created event successfully');
      // createEvent(action).then((Response response) {
      // store.dispatch(FetchEventsAction());
      // });
    }
  } else if (action is DeleteEventAction) {
    if (action.type == EventActionType.delete) {
      deleteEvent(action).then((Response response) {
        store.dispatch(FetchEventsAction());
      });
    }
  }
  // Important: Call the next middleware in the chain
  next(action);
}

List<EventWithId> parseEvents(String jsonString) {
  final decoded = json.decode(jsonString);
  final data = decoded['data'] as Map<String, dynamic>?;
  if (data == null) {
    throw Exception('Data is null');
  }
  final getEvents = data['getEvents'] as List<dynamic>?;
  if (getEvents == null) {
    throw Exception('getEvents is null');
  }
  return getEvents
      .map<EventWithId>((json) => EventWithId.fromJson(json))
      .toList();
}
