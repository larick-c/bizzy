import 'package:bizzy/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({super.key, required this.callback});
  final Function callback;

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(index) {
    widget.callback(index);
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
                    NavigationDestination(icon: ImageIcon(AssetImage('assets/icons_white/todo_white.png')), selectedIcon: ImageIcon(AssetImage('assets/icon/1-27.png')), label: ""),
                    NavigationDestination(icon: ImageIcon(AssetImage('assets/icons_white/camera_white.png')), selectedIcon: ImageIcon(AssetImage('assets/icon/1-05.png')), label: ""),
                    NavigationDestination(icon: ImageIcon(AssetImage('assets/icons_white/video_white.png')), selectedIcon: ImageIcon(AssetImage('assets/icon/1-18.png')), label: ""),
                  ],
                  onDestinationSelected: pageIndexCallback
                  )
            ),
          ],
      )
    );
  }
}