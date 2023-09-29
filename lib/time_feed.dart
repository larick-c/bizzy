import 'package:bizzy/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TimeFeed extends StatefulWidget {
  const TimeFeed({super.key, required this.callback});
  final Function callback;

  @override
  State<TimeFeed> createState() => _TimeFeedState();
}

class _TimeFeedState extends State<TimeFeed> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(index) {
    widget.callback("timeFeed", index);
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
                    NavigationDestination(icon: ImageIcon(AssetImage('assets/icon/1-27.png')), label: ""),
                    NavigationDestination(icon: ImageIcon(AssetImage('assets/icon/1-06.png')), label: ""),
                    NavigationDestination(icon: ImageIcon(AssetImage('assets/icon/1-18.png')), label: ""),
                  ],
                  onDestinationSelected: pageIndexCallback
                  )
            ),
            const Expanded(flex: 15, child: Image(image: AssetImage('assets/icon/time.png'),),),
          ],
      )
    );
  }
}