import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NutritionMacroPage extends StatefulWidget {
  const NutritionMacroPage({super.key});

  @override
  State<NutritionMacroPage> createState() => _NutritionMacroPageState();
}

class _NutritionMacroPageState extends State<NutritionMacroPage> {
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
              child: Image(
                image: AssetImage('assets/icon/nutrition_fill.png'),
              ),
            ),
          ],
        ));
  }
}
