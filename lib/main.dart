import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/LandingPage/landingHelpers.dart';
import 'package:college_space/screens/Splashscreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build( BuildContext context){
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
          home: Splashscreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: constantColors.blueColor,
              fontFamily: 'Poppins',
              canvasColor: Colors.transparent
          ),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => LandingHelpers())
        ]
    );
  }
}
