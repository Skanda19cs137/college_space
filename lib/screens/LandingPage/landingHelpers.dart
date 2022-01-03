import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Homepage/Homepage.dart';
import 'package:college_space/screens/LandingPage/LandingUtil.dart';
import 'package:college_space/screens/LandingPage/landingServices.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  Widget bodyImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/login.png'))),
    );
  }

  Widget taglineText(BuildContext context) {
    return Positioned(
      top: 450.0,
      left: 10.0,
      child: Container(
        constraints: BoxConstraints(maxWidth: 350.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
            text: TextSpan(
              text: "Interact , Innovate , Inspire .",
              style: TextStyle(
                color: constantColors.lightBlueColor,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget mainButton(BuildContext context) {
    return Positioned(
        top: 560.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Google Sign In
              GestureDetector(
                onTap: () {
                  print("Sign In with Google:");
                  Provider.of<Authentication>(context, listen: false)
                      .signInWithGoogle()
                      .whenComplete(() {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: Homepage(),
                            type: PageTransitionType.leftToRightWithFade));
                  });
                },
                child: Container(
                  child: Icon(FontAwesomeIcons.google,
                      color: constantColors.whiteColor),
                  width: 80.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.blueColor),
                      borderRadius: BorderRadius.circular(10.0),
                      color:constantColors.blueColor
                  ),
                ),
              ),
              //Email Sign In
              GestureDetector(
                onTap: () {
                  emailAuthSheet(context);
                },
                child: Container(
                  child:
                      Icon(Icons.email_rounded, color: constantColors.whiteColor),
                  width: 80.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.redColor),
                      borderRadius: BorderRadius.circular(10.0),
                      color: constantColors.redColor
                  ),
                ),
              )
            ],
          ),
        ));
  }

  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                Provider.of<LandingService>(context, listen: false)
                    .passwordlessSignIn(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text(
                          'Log In',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Provider.of<LandingService>(context,listen: false).logInSheet(context);
                        }),
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          Provider.of<LandingUtils>(context,listen: false).selectAvatarOptionsSheet(context);
                        }),
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
          );
        });
  }


}
