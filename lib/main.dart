import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bizzy/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // graph();
  runApp(const Bizzy());
}

class Bizzy extends StatelessWidget {
  const Bizzy({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home());
  }
}
