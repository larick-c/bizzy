import 'package:bizzyupdated/Calculator_App.dart';
import 'package:bizzyupdated/FinanceApp.dart';
import 'package:bizzyupdated/FitnessApp.dart';
import 'package:bizzyupdated/NutritionApp.dart';
import 'package:bizzyupdated/Search_Button.dart';
import 'package:bizzyupdated/screen_3.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarApp extends StatefulWidget {
  @override
  _CalendarAppState createState() => _CalendarAppState();
}

class _CalendarAppState extends State<CalendarApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, // Remove default back button
          backgroundColor: Colors.white,
          actions: [
            Align(
              // alignment: Alignment.center,
              child: FractionalTranslation(
                translation: const Offset(-0.8, 0.0), // Adjust the Offset values for desired positioning
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.1,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalendarApp(),
                            ),
                          );
                        },
                        icon: Image.asset('assets/images/calender.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          title: Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: const Offset(-0.0, 0.0), // Adjust the Offset values for desired positioning
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 1.1,
                    child: IconButton(
                      onPressed: () {

                      },
                      icon: Image.asset('assets/images/time.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          leading: Align(
            alignment: Alignment.center,
            child: FractionalTranslation(
              translation: const Offset(0.5, 0.0), // Adjust the Offset values for desired positioning
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 1.7,
                    child: IconButton(

                      onPressed: () {
                        // Handle center icon button tap
                      },
                      icon: Image.asset('assets/images/profile.png'),

                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TableCalendar(
          focusedDay: DateTime.now(), // Set the focusedDay to the current date
          firstDay: DateTime(DateTime.now().year, 1, 1), // Set the first selectable day to the beginning of the current year
          lastDay: DateTime(DateTime.now().year, 12, 31), // Set the last selectable day to the end of the current year
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFbd5d9f),
                  Color(0xFF7b4e92),
                  Color(0xFF6ec1d6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            todayDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFbd5d9f),
                  Color(0xFF7b4e92),
                  Color(0xFF6ec1d6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            todayTextStyle: TextStyle(color: Colors.white), // Set the text color for the current day
          ),
        ),

        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.scale(
                scale: 0.8,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavigationApp(),
                      ),
                    );
                  },
                  icon: Image.asset('assets/images/Home_icon1.png'),
                ),
              ),
              Transform.scale(
                scale: 0.8,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Search_button(),
                      ),
                    );
                  },
                  icon: Image.asset('assets/images/search_icon1.png'),
                ),
              ),
              Transform.scale(
                scale: 1.2,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FitnessApp(),
                      ),
                    );

                  },
                  icon: Image.asset('assets/images/gym_icon1.png'),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NutritionApp(),
                      ),
                    );
                  },
                  icon: Image.asset('assets/images/res_icon1.png'),
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: IconButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FinanceApp(),
                      ),
                    );
                  },
                  icon: Image.asset('assets/images/exp_icon1.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}