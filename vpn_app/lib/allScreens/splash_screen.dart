import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:vpn_basic_project/allScreens/home_screen.dart';

import '../appPreferences/app_preferences.dart';
// Replace with your main application screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading delay
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = MediaQuery.of(context).size;

    // Determine which image to show based on the current theme
    String imagePath = AppPreferences.isModeDark
        ? 'assets/images/devvpn.png'
        : 'assets/images/devvpn.png';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: sizeScreen.height * 0.15,
              height: sizeScreen.height * 0.15,
              child: Image.asset(
                imagePath,
                width: sizeScreen.height * 0.2,
                height: sizeScreen.height * 0.2,
                fit: BoxFit.cover,
              ),
            ),
            LoadingAnimationWidget.dotsTriangle(
              color: Color.fromARGB(255, 98, 86, 86),
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}
