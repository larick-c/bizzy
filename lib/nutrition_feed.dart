import 'package:bizzy/custom_app_bar.dart';
import 'package:bizzy/nutrition_macro_page.dart';
import 'package:bizzy/nutrition_search_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NutritionFeed extends StatefulWidget {
  const NutritionFeed({super.key});

  @override
  State<NutritionFeed> createState() => _NutritionFeedState();
}

class _NutritionFeedState extends State<NutritionFeed> {
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
            Expanded(
              child: CustomAppBarState(destinations: const <Widget>[
                NavigationDestination(
                    icon: ImageIcon(AssetImage('assets/icon/nutrition.png')),
                    label: ""),
                NavigationDestination(
                    icon: ImageIcon(AssetImage('assets/icon/search.png')),
                    label: ""),
              ], onDestinationSelected: pageIndexCallback),
            ),
            Expanded(
              flex: 15,
              child: <Widget>[
                const NutritionMacroPage(),
                const NutritionSearchPage()
              ][currentPageIndex],
            ),
          ],
        ));
  }
}
