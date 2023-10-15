import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TextFeed extends StatefulWidget {
  const TextFeed({super.key});

  @override
  State<TextFeed> createState() => _TextFeedState();
}

class _TextFeedState extends State<TextFeed> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  @override
  Widget build(BuildContext context) {
    return         
    Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: const Column(
        children: 
          <Widget>[ 
            Expanded(flex: 15, child: Image(image: AssetImage('assets/icon/1-27.png'),),),
          ],
      )
    );
  }
}