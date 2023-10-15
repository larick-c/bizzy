import 'package:bizzy/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class WeightTrainingPage extends StatefulWidget {
  const WeightTrainingPage({super.key});

  @override
  State<WeightTrainingPage> createState() => _WeightTrainingPageState();
}

class _WeightTrainingPageState extends State<WeightTrainingPage> {
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
              child: NoteApp(),
            ),
          ],
        ));
  }
}
