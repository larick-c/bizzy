import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class PhotoFeed extends StatefulWidget {
  const PhotoFeed({super.key});

  @override
  State<PhotoFeed> createState() => _PhotoFeedState();
}

class _PhotoFeedState extends State<PhotoFeed> {

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
            Expanded(flex: 15, child: Image(image: AssetImage('assets/icon/1-06.png'),),),
          ],
      )
    );
  }
}