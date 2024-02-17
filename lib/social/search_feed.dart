import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({super.key});

  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
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
                image: AssetImage('assets/icon/search_fill.png'),
              ),
            ),
          ],
        ));
  }
}
