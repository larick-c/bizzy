import 'package:bizzy/custom_app_bar.dart';
import 'package:bizzy/finance/finance_calendar_page.dart';
import 'package:bizzy/finance/finance_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FinanceFeed extends StatefulWidget {
  const FinanceFeed({super.key});

  @override
  State<FinanceFeed> createState() => _FinanceFeedState();
}

class _FinanceFeedState extends State<FinanceFeed> {
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
                      icon: ImageIcon(AssetImage('assets/icon/finance.png')),
                      label: ""),
                  NavigationDestination(
                      icon: ImageIcon(
                          AssetImage('assets/icon/calendar_fill.png')),
                      label: ""),
                ], onDestinationSelected: pageIndexCallback)),
            Expanded(
              child: <Widget>[
                const FinancePage(),
                const FinanceCalendarPage()
              ][currentPageIndex],
            ),
          ],
        ));
  }
}
