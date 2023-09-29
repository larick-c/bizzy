import 'package:bizzy/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SearchFeed extends StatefulWidget {
  const SearchFeed({super.key, required this.callback});
  final Function callback;

  @override
  State<SearchFeed> createState() => _SearchFeedState();
}

class _SearchFeedState extends State<SearchFeed> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(index) {
    widget.callback("searchFeed", index);
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
            const Expanded(flex: 15, child: Image(image: AssetImage('assets/icon/search_fill.png'),),),
          ],
      )
    );
  }
}