import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomAppBarState extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarState({super.key, required this.destinations, required this.onDestinationSelected});

  final List<Widget> destinations;
  final Function onDestinationSelected;
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(40.0);

  @override
  State<CustomAppBarState> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBarState> {

  int currentPageIndex = 0;

  var logger = Logger(
    printer: PrettyPrinter(),
  );
  @override
  Widget build(BuildContext context) {
    return 
      AppBar(
        flexibleSpace: 
        Container(
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("assets/icon/1-02.png"), fit: BoxFit.cover),), 
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            animationDuration: Duration.zero,
            onDestinationSelected: (int index) {
              setState(() {
                widget.onDestinationSelected(index);
              });
            },
            destinations: widget.destinations
          ),
        ),
      );
  }
}