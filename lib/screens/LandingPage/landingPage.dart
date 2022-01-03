import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'landingHelpers.dart';

class Landingpage extends StatefulWidget {
  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  final ConstantColors constantColors = ConstantColors();
  void initstate(){
    Provider.of<FirebaseOperations>(context,listen: false).initUserData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Stack(
        children: [
          bodyColor(),
          Provider.of<LandingHelpers>(context, listen:false).bodyImage(context),
          Provider.of<LandingHelpers>(context, listen:false).taglineText(context),
          Provider.of<LandingHelpers>(context, listen:false).mainButton(context),
        ],
      ),
    );
  }

  bodyColor(){
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5,0.9],
            colors: [constantColors.darkColor, constantColors.blueGreyColor]
          )
      ),
    );
  }
}
