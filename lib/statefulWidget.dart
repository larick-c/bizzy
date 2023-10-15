import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class StateFullWidget extends StatelessWidget {
  const StateFullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StateFullWidgetState(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blue
        ),
        navigationBarTheme: 
          const NavigationBarThemeData(
            // height: 20,
            backgroundColor: Colors.transparent
          ),
        hoverColor: Colors.transparent, 
        splashColor: Colors.transparent, 
        iconTheme: const IconThemeData())
    );
  }
}

class StateFullWidgetState extends StatefulWidget {
  const StateFullWidgetState({super.key});

  @override
  State<StateFullWidgetState> createState() => _StateFullWidgetState();
}

class _StateFullWidgetState extends State<StateFullWidgetState> {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  @override
  Widget build(BuildContext context) {
    return const Text("StateFullWidgetState Text");
  }
}