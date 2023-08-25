import 'package:flutter/material.dart';
import '../utils/app_util.dart';

class ElevatedButtonG extends StatelessWidget {
  final String title;
  final VoidCallback onPress;

  const ElevatedButtonG({Key? key, required this.title, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppUtil.getDeviceWidth() * 0.637,
      height: AppUtil.getDeviceHeight() * 0.07,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.transparent,
          ),
          elevation: MaterialStateProperty.all<double>(0), // Set the elevation to 0
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFbd5d9f),
                Color(0xFF7b4e92),
                Color(0xFF6ec1d6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 27.0,
                letterSpacing: 1.3,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
