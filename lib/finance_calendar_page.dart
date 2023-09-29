import 'package:bizzy/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FinanceCalendarPage extends StatefulWidget {
  const FinanceCalendarPage({super.key, required this.callback});
  final Function callback;

  @override
  State<FinanceCalendarPage> createState() => _FinanceCalendarPageState();
}

class _FinanceCalendarPageState extends State<FinanceCalendarPage> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(index) {
    widget.callback("financeCalendarPage", index);
  }
  @override
  Widget build(BuildContext context) {
    return         
    Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Column(
        children: 
          <Widget>[ 
            Expanded(
              child: CustomAppBarState(
                destinations: const <Widget> [
                  NavigationDestination(icon: ImageIcon(AssetImage('assets/icon/finance.png')), label: ""),
                  NavigationDestination(icon: ImageIcon(AssetImage('assets/icon/calendar_fill.png')), label: ""),
                ],
                onDestinationSelected: pageIndexCallback
              ),
            ),
            const Expanded(flex: 15, child: Image(image: AssetImage('assets/icon/calendar_fill.png'),),),
          ],
      )
    );
  }
}