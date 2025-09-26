import 'package:flutter/material.dart';
import 'dart:async';

// Assume you have a main screen named HomeScreen.dart
// You'll need to create this file.
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    _startTimer();
  }

  void _startTimer() {
    // Duration for the splash screen display
    const duration = Duration(seconds: 3);

    // After the duration, navigate to the next screen
    Timer(duration, () {
      // Ensure the widget is still in the tree before navigating
      if (mounted) {
        // Navigate to the HomeScreen and replace the current route
        // so the user cannot navigate back to the splash screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Set a background color appropriate for your app
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // --- App Logo/Icon ---
            Icon(
              Icons.house_siding_rounded,
              color: Colors.white,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            // --- App Name ---
            Text(
              'Rental Hub',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            // Optional: Loading indicator
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}