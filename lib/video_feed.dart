import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class VideoFeed extends StatefulWidget {
  const VideoFeed({super.key});

  @override
  State<VideoFeed> createState() => _VideoFeedState();
}

class _VideoFeedState extends State<VideoFeed> {

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
            Expanded(flex: 15, child: Image(image: AssetImage('assets/icon/1-18.png'),),),
          ],
      )
    );
  }
}