import 'package:bizzyupdated/CalendarApp.dart';
import 'package:bizzyupdated/Play_button.dart';
import 'package:bizzyupdated/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationApp extends StatefulWidget {
  @override
  _BottomNavigationAppState createState() => _BottomNavigationAppState();
}

class _BottomNavigationAppState extends State<BottomNavigationApp> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
    Screen5(),
  ];

  List<bool> _selectedButtons = List.generate(5, (index) => false);

  void _onItemTapped(int index) {
    setState(() {
      _selectedButtons[_currentIndex] = false; // Reset the previous selected button
      _currentIndex = index;
      _selectedButtons[_currentIndex] = true; // Set the current button as selected
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove default back button
        backgroundColor: Colors.white,
        actions: [
          Align(
            // alignment: Alignment.center,
            child: FractionalTranslation(
              translation: const Offset(-0.8, 0.0), // Adjust the Offset values for desired positioning
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: 1.1,
                    child: IconButton(
                      onPressed: () {
                        // Get.off(CalendarApp());
                      },
                      icon: Image.asset('assets/images/calender.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        title: Align(
          alignment: Alignment.center,
          child: FractionalTranslation(
            translation: const Offset(-0.0, 0.0), // Adjust the Offset values for desired positioning
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.1,
                  child: IconButton(
                    onPressed: () {

                    },
                    icon: Image.asset('assets/images/time.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: Align(
          alignment: Alignment.center,
          child: FractionalTranslation(
            translation: const Offset(0.5, 0.0), // Adjust the Offset values for desired positioning
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 1.7,
                  child: IconButton(

                    onPressed: () {
                      // Handle center icon button tap
                    },
                    icon: Image.asset('assets/images/profile.png'),

                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
          children: [
            Align(
              alignment: Alignment.center,
              // child : Stack(
              //   children: [
              //     Image.asset(
              //       'assets/images/back2.png',
              //       fit: BoxFit.cover,
              //
              //       // Adjust other properties of the Image widget as needed
              //     ),
              //     // Row(
              //     //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     //   children: [
              //     //     Transform.scale(
              //     //       scale: 0.8,
              //     //       child: IconButton(
              //     //         onPressed: () {
              //     //           // Get.off(const home_screen());
              //     //           // Navigator.pushReplacement(
              //     //           //   context,
              //     //           //   MaterialPageRoute(
              //     //           //     builder: (context) => const HomeScreen(),
              //     //           //   ),
              //     //           // );
              //     //         },
              //     //         icon: Image.asset('assets/images/todo_icon1.png'),
              //     //       ),
              //     //     ),
              //     //     // Transform.scale(
              //     //     //   scale: 0.0,
              //     //     //   child: Image.asset(
              //     //     //       'assets/images/white_line.png'),
              //     //     // ),
              //     //
              //     //     Transform.scale(
              //     //       scale: 0.8,
              //     //       child: IconButton(
              //     //         onPressed: () {
              //     //           Get.off( BottomNavigationApp());
              //     //         },
              //     //         icon: Image.asset('assets/images/camera_icon2.png'),
              //     //       ),
              //     //     ),
              //     //     // Transform.scale(
              //     //     //   scale: 0.3,
              //     //     //   child: Image.asset(
              //     //     //       'assets/images/white_line.png'),
              //     //     // ),
              //     //     Transform.scale(
              //     //       scale: 0.9,
              //     //       child: IconButton(
              //     //         onPressed: () {
              //     //           Get.off(const Play_Button());
              //     //         },
              //     //         icon: Image.asset('assets/images/play_icon1.png'),
              //     //       ),
              //     //     ),
              //     //
              //     //
              //     //
              //     //   ],
              //     // ),
              //   ],
              // ),
            ),
            Expanded(
              child:  _screens[_currentIndex],
            ),
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem('assets/images/Home_icon1.png', 'Screen 1', 0),
          _buildBottomNavigationBarItem('assets/images/search_icon1.png', 'Screen 2', 1),
          _buildBottomNavigationBarItem('assets/images/gym_icon1.png', 'Screen 3', 2),
          _buildBottomNavigationBarItem('assets/images/res_icon1.png', 'Screen 4', 3),
          _buildBottomNavigationBarItem('assets/images/exp_icon1.png', 'Screen 5', 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
  String imagePath, String label, int index) {
    List<Color> gradientColors = [
      Color(0xFFbd5d9f),
      Color(0xFF7b4e92),
      Color(0xFF6ec1d6),
    ];

    Color color = _selectedButtons[index] ? Colors.blue : Colors.black;

    return BottomNavigationBarItem(
      icon: Container(
        height: 40,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_selectedButtons[index]) // Add line effect above the icon
              Container(
                margin: EdgeInsets.only(bottom: 4),
                height: 5,
                width: 50,
                color: Colors.blue, // Customize the line color
              ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ).createShader(bounds);
              },
              child: Image.asset(
                imagePath,
                color: color,
                width: 30,
                height: 25,
              ),
            ),
          ],
        ),
      ),
      label: label,
    );
  }
}
class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 600, // Set the desired height
        child: Image.asset(
          'assets/images/main_pic2.jpg',
          fit: BoxFit.fill, // Adjust the fit property as needed
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // Align the image to the top center
      child: Image.asset(
        'assets/images/Search_pic.jpg',
        fit: BoxFit.cover, // Adjust the fit property as needed
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // Align the image to the top center
      child: Image.asset(
        'assets/images/gym_button.jpg',
        fit: BoxFit.cover, // Adjust the fit property as needed
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // Align the image to the top center
      child: Image.asset(
        'assets/images/Nutrition_button.jpg',
        fit: BoxFit.cover, // Adjust the fit property as needed
      ),
    );
  }
}

class Screen5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter, // Align the image to the top center
      child: Image.asset(
        'assets/images/expense_pic.jpg',
        fit: BoxFit.cover, // Adjust the fit property as needed
      ),
    );
  }
}