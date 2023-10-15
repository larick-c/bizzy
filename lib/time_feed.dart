import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TimeFeed extends StatefulWidget {
  const TimeFeed({super.key});

  @override
  State<TimeFeed> createState() => _TimeFeedState();
}

class _TimeFeedState extends State<TimeFeed> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: const Column(
          children: <Widget>[
            Expanded(
              flex: 15,
              child: Image(
                image: AssetImage('assets/icon/time.png'),
              ),
            ),
          ],
        ));
  }
}
