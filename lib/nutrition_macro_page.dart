import 'package:bizzy/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NutritionMacroPage extends StatefulWidget {
  const NutritionMacroPage({super.key, required this.callback});
  final Function callback;

  @override
  State<NutritionMacroPage> createState() => _NutritionMacroPageState();
}

class _NutritionMacroPageState extends State<NutritionMacroPage> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );

  pageIndexCallback(index) {
    widget.callback("nutritionMacroPage", index);
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
                  NavigationDestination(icon: ImageIcon(AssetImage('assets/icon/nutrition.png')), label: ""),
                  NavigationDestination(icon: ImageIcon(AssetImage('assets/icon/search.png')), label: ""),
                ],
                onDestinationSelected: pageIndexCallback
                ),
            ),
            const Expanded(flex: 15, child: Image(image: AssetImage('assets/icon/nutrition_fill.png'),),),
          ],
      )
    );
  }
}