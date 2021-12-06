import 'dart:async';
import 'package:college_space/screens/LandingPage/landingPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  ConstantColors constantColors = ConstantColors();

  @override
  void initState() {
    Timer(
      Duration(
        seconds: 2
      ),
        () => Navigator.pushReplacement(context, PageTransition( type: PageTransitionType.fade, child: Landingpage()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: Center(
        child: RichText(
          text: TextSpan(
              text: 'College',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
              children: <TextSpan>[
                TextSpan(
                    text: 'Space',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: constantColors.blueColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 34.0))
              ]),
        ),
      ),
    );
  }
}
