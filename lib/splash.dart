import 'package:flutter/material.dart';
import 'package:nebulaboard/home.dart';
import 'package:nebulaboard/intro_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the main screen after the splash screen
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => IntroScreens(
          onDone: () { 
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          })));
    });
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Centered logo
          Center(
            child: Image.asset('assets/logo.png', width: 350, height: 300),
          ),
          
          // Loading indicator at the bottom
          Positioned(
            bottom: 50, // Adjust this value to control distance from bottom
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset('assets/loading.gif', width: 120, height: 120),
            ),
          ),
        ],
      ),
    );
  }
}