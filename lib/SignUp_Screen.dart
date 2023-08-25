import 'package:bizzyupdated/Controllers/SignUp_Controller.dart';
import 'package:bizzyupdated/SignIn_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:bizzyupdated/widgets/elevated_button_g.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as Svg;
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _image;
  bool agreeToTerms = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    // Dispose the text editing controllers
    usernameController.dispose();
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 75.0),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Create Account ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                GestureDetector(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: ClipOval(
                    child: SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image != null
                                ? FileImage(_image!) as ImageProvider<Object>
                                : AssetImage('assets/images/default.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: _image == null
                            ? SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: Image.asset(
                            'assets/images/default.png',
                            fit: BoxFit.contain,
                          ),
                        )
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Upload Your Photo',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 50.0,
                  child: Stack(
                    children: [
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFbd5d9f),
                                Color(0xFF7b4e92),
                                Color(0xFF6ec1d6),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Stack(
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFbd5d9f),
                                Color(0xFF7b4e92),
                                Color(0xFF6ec1d6),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 50.0,
                  child: Stack(
                    children: [
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFbd5d9f),
                                Color(0xFF7b4e92),
                                Color(0xFF6ec1d6),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Stack(
                    children: [
                      TextField(
                        controller: dobController,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFbd5d9f),
                                Color(0xFF7b4e92),
                                Color(0xFF6ec1d6),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.0,
                  child: Stack(
                    children: [
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 4.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFbd5d9f),
                                Color(0xFF7b4e92),
                                Color(0xFF6ec1d6),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeToTerms = value!;
                        });
                      },
                    ),
                    TextButton(
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'I agree with terms & conditions ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ElevatedButtonG(
                  title: 'Sign Up',
                  onPress: () async {
                    String username = usernameController.text;
                    String name = nameController.text;
                    String email = emailController.text;
                    String dob = dobController.text;
                    String password = passwordController.text;

                    try {
                      // Create a new user in Firebase Authentication
                      UserCredential userCredential =
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      // Additional logic...
                      // You can store additional user information in Firestore or perform any other desired actions

                      // Navigate to the sign-in screen
                      Get.offAll(() => const SignInScreen());
                    } catch (e) {
                      // Handle sign-up errors
                      print('Sign up error: $e');
                      // Show an error message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sign up failed. Please try again.'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
