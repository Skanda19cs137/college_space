
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/LandingPage/landingPage.dart';
import 'package:college_space/screens/Profile/ProfileHelpers.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            EvaIcons.settings2Outline,
            color: constantColors.greenColor
          ),
          onPressed: (){},
        ),
        actions: [
          IconButton(icon: Icon(EvaIcons.logOutOutline,
          color: constantColors.greenColor,) ,
            onPressed: () {
              Provider.of<ProfileHelpers>(context,listen:false).logOutDialog(context);
            },)
        ],
          backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
          title: RichText(
            text: TextSpan(
                text: 'My',
                style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Profile',
                    style: TextStyle(
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  )
                ]),
          ),
        ),

        body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.only(top: 8.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(Provider.of<Authentication>(context, listen: false)
                      .getUserUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return new Column(
                    children: [
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .headerProfile(context, snapshot),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .divider(),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .middleProfile(context, snapshot),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .footerProfile(context, snapshot)
                    ],
                  );
                }
              },
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: constantColors.blueGreyColor.withOpacity(0.6)),
          ),
        ),
      ),
    ); // Scaffold
  }
  logOutDialog(BuildContext context){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Log Out of the Soical?',style: TextStyle(
       color: constantColors.whiteColor,
       fontSize: 16.0,
       fontWeight: FontWeight.bold
        ),),
        actions: [
          MaterialButton(
              child: Text('No',style: TextStyle(
                color:constantColors.whiteColor,
                decoration: TextDecoration.underline
              )),
              onPressed: )
        ],
      );
    });
  }
}
