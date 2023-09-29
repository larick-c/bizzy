import 'package:bizzy/custom_app_bar.dart';
import 'package:bizzy/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class WeightTrainingPage extends StatefulWidget {
  const WeightTrainingPage({super.key, required this.callback});
  final Function callback;

  @override
  State<WeightTrainingPage> createState() => _WeightTrainingPageState();
}

class _WeightTrainingPageState extends State<WeightTrainingPage> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(index) {
    widget.callback("weightTrainingPage", index);
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
                  NavigationDestination(icon: ImageIcon(AssetImage('assets/icons_white/weight_white.png')), label: ""),
                  NavigationDestination(icon: Icon(color: Colors.white, Icons.directions_run,), label: ""),
                ],
                onDestinationSelected: pageIndexCallback
              ),
            ),
            const Expanded(flex: 15, child: NoteApp(),),
          ],
      )
    );
  }
}