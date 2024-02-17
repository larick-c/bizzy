import 'package:bizzy/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CardioTrainingPage extends StatefulWidget {
  const CardioTrainingPage({super.key});

  @override
  State<CardioTrainingPage> createState() => _CardioTrainingPageState();
}

class _CardioTrainingPageState extends State<CardioTrainingPage> {
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
              child: NoteApp(),
            ),
          ],
        ));
  }
}
