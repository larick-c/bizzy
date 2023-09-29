import 'package:bizzy/home_page_appBar.dart';
import 'package:bizzy/photo_feed.dart';
import 'package:bizzy/text_feed.dart';
import 'package:bizzy/video_feed.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    return         
    Container(
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Column(
        children: 
          <Widget>[ 
            Expanded(
              child: HomePageAppBar(callback: pageIndexCallback)
            ),
            Expanded(
              flex: 15, 
              child: <Widget>[
                const TextFeed(),
                const PhotoFeed(),
                const VideoFeed(),
              ][currentPageIndex]
            ),
          ],
      )
    );
  }
}