import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bizzy/AppState.dart';
import 'package:bizzy/calendar/calendar_feed.dart';
import 'package:bizzy/finance/finance_feed.dart';
import 'package:bizzy/fitness/fitness_feed.dart';
import 'package:bizzy/home/AppReducer.dart';
import 'package:bizzy/home/FetchMiddleware.dart';
import 'package:bizzy/home/home_page.dart';
import 'package:bizzy/main.dart';
import 'package:bizzy/nutrition/nutrition_feed.dart';
import 'package:bizzy/profile/profile_feed.dart';
import 'package:bizzy/social/search_feed.dart';
import 'package:bizzy/time_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';

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

Future<void> signOutCurrentUser() async {
  final result = await Amplify.Auth.signOut();
  if (result is CognitoCompleteSignOut) {
    safePrint('Sign out completed successfully');
  } else if (result is CognitoFailedSignOut) {
    safePrint('Error signing user out: ${result.exception.message}');
  }
}
