import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SignUpController extends GetxController {
  // Add necessary fields and methods for sign-up functionality

  final username = ''.obs;
  final name = ''.obs;
  final email = ''.obs;
  final dateOfBirth = ''.obs;
  final password = ''.obs;

  void signUp() async {
    try {
      // Create a user with email and password using Firebase Authentication
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );

      // You can access the newly created user using userCredential.user

      // Perform additional logic here, such as storing user information in Firestore
      // For example, you can use FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set(...) to store user data

      // Reset the input fields after successful sign-up
      username.value = '';
      name.value = '';
      email.value = '';
      dateOfBirth.value = '';
      password.value = '';

      // Show success message or navigate to the next screen
      Get.snackbar(
        'Sign Up Successful',
        'You have successfully signed up!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate to the next screen
      // You can use Get.offAll, Get.offNamed, or any other navigation method provided by Get package
      // Example:
      // Get.offAll(() => NextScreen());
    } catch (error) {
      // Handle any errors that occur during sign-up
      // Show error message or perform error handling
      Get.snackbar(
        'Sign Up Error',
        'An error occurred during sign-up. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

