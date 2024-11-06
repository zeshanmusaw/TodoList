import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todolist/common/contansts/common_color.dart';
import 'dart:async';
import 'home_screen.dart'; // Import the HomeScreen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to HomeScreen after a delay

    // Use post-frame callback to ensure the context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Navigate to the next screen after the first frame is drawn
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your target screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor, // Background color for the splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/logo.svg',height: 300,), // App icon or logo
            const SizedBox(height: 20),
            const Text(
              'To-Do List',
              style: TextStyle(
                fontSize: 24.0,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
           // Loading indicator
          ],
        ),
      ),
    );
  }
}
