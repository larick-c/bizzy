import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NutritionSearchPage extends StatefulWidget {
  const NutritionSearchPage({super.key});

  @override
  State<NutritionSearchPage> createState() => _NutritionSearchPageState();
}

class _NutritionSearchPageState extends State<NutritionSearchPage> {
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
                image: AssetImage('assets/icon/search_fill.png'),
              ),
            ),
          ],
        ));
  }
}
