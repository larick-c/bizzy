import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';



class Calculator_App extends StatefulWidget {
  const Calculator_App({Key? key}) : super(key: key);

  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<Calculator_App> {
  String _expression = '';

  void _onButtonPressed(String text) {
    setState(() {
      if (text == 'C') {
        _expression = '';
      } else if (text == 'x') {
        // Replace 'x' with '*'
        _expression += '*';
      } else if (text == '=') {
        _onCalculateButtonPressed();
      } else {
        _expression += text;
      }
    });
  }

  void _onCalculateButtonPressed() {
    Parser parser = Parser();
    Expression exp = parser.parse(_expression);

    try {
      ContextModel contextModel = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        _expression = result.toString();
      });
    } catch (e) {
      setState(() {
        _expression = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Remove default back button
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFbd5d9f),
                Color(0xFF7b4e92),
                Color(0xFF6ec1d6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          '         Calculator',
          style: TextStyle(fontSize: 35.0), // Adjust the text size here
        ),
      ),


      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  _expression,
                  style: const TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const Divider(height: 0),
          _buildButtonsRow(['7', '8', '9', '/']),
          _buildButtonsRow(['4', '5', '6', 'x']),
          _buildButtonsRow(['1', '2', '3', '-']),
          _buildButtonsRow(['.', '0', 'C', '+']),
          SizedBox(
            width: double.infinity,
            height: 100.0,
            child: ElevatedButton(
              onPressed: () => _onButtonPressed('='),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.transparent, padding: const EdgeInsets.all(7.0), backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ), // Set onPrimary color to transparent
              ).copyWith(
                // Set the background color to transparent
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Colors.transparent;
                  },
                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFbd5d9f),
                      Color(0xFF7b4e92),
                      Color(0xFF6ec1d6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    '  =',
                    style: const TextStyle(fontSize: 40.0, color: Colors.white), // Set text color to white
                  ),
                ),
              ),
            ),
          )





        ],
      ),
    );
  }

  Widget _buildButtonsRow(List<String> buttonLabels) {
    return Expanded(
      child: Row(
        children: buttonLabels
            .map((label) => _buildButton(label))
            .toList(growable: false),
      ),
    );
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(label),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(6.0), backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ), // Set primary color to transparent
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFbd5d9f),
                  Color(0xFF7b4e92),
                  Color(0xFF6ec1d6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                label,
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
