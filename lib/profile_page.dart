import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProfilePageState(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blue
        ),
        navigationBarTheme: 
          const NavigationBarThemeData(
            // height: 20,
            backgroundColor: Colors.white
          ),
        hoverColor: Colors.transparent, 
        splashColor: Colors.transparent, 
        iconTheme: const IconThemeData())
    );
  }
}

class ProfilePageState extends StatefulWidget {
  const ProfilePageState({super.key});

  @override
  State<ProfilePageState> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageState> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
      return Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        child: const Image(image: AssetImage('assets/icon/profile.png'))
      );
  }
}