import 'package:bizzy/fitness/cardio_training_page.dart';
import 'package:bizzy/custom_app_bar.dart';
import 'package:bizzy/weight_training_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FitnessFeed extends StatefulWidget {
  const FitnessFeed({super.key});

  @override
  State<FitnessFeed> createState() => _FitnessFeedState();
}

class _FitnessFeedState extends State<FitnessFeed> {
  int currentPageIndex = 0;

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 16,
              child: CustomAppBarState(destinations: const <Widget>[
                NavigationDestination(
                    icon: ImageIcon(
                        AssetImage('assets/icons_white/weight_white.png')),
                    label: ""),
                NavigationDestination(
                    icon: Icon(
                      color: Colors.white,
                      Icons.directions_run,
                    ),
                    label: ""),
              ], onDestinationSelected: pageIndexCallback),
            ),
            Expanded(
              child: <Widget>[
                const WeightTrainingPage(),
                const CardioTrainingPage()
              ][currentPageIndex],
            ),
          ],
        ));
  }
}
