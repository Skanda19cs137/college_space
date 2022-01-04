import 'dart:ui';

import 'package:college_space/screens/AltProfile/alt_profile.dart';
import 'package:college_space/screens/LandingPage/landingPage.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:js/js.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

ConstantColors constantColors = ConstantColors();

class ProfileHelpers with ChangeNotifier {
  Widget headerProfile(BuildContext context, dynamic snapshot) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 220.0,
              width: 180.0,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                          backgroundColor: constantColors.transperant,
                          radius: 60.0,
                          backgroundImage:(snapshot.data.data()['userimage']!=null)?
                              NetworkImage(snapshot.data.data()['userimage']):AssetImage('assets/images/empty.png')
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(snapshot.data.data()['username'],
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.email,
                            color: constantColors.greenColor, size: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 3.0),
                          child: Text(snapshot.data.data()['useremail'],
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 16.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:(){
                            CheckFollowersSheet(context,snapshot);
                        },

                      child: Container(
                          decoration: BoxDecoration(
                              color: constantColors.darkColor,
                              borderRadius: BorderRadius.circular(15.0)),
                          height: 70.0,
                          width: 80.0,
                          child: Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('users').doc(
                                      snapshot.data.data()['useruid']
                                  ).collection('followers').snapshots(),
                                  builder: (context,snapshot){
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(child: CircularProgressIndicator());
                                    }
                                    else{
                                      return new Text(snapshot.data.docs.length.toString(),
                                          style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 28.0));
                                    }
                                  }),
                              Text('Followers',
                                  style: TextStyle(
                                      color: constantColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0)),
                            ],
                          ),
                      ),
                     GestureDetector(
                       onTap: (){
                         CheckFollowingSheet(context,snapshot)
                       },
                     child:
                     Container(
                        decoration: BoxDecoration(
                            color: constantColors.darkColor,
                            borderRadius: BorderRadius.circular(15.0)),
                        height: 70.0,
                        width: 80.0,
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('users').doc(
                                    snapshot.data.data()['useruid']
                                ).collection('following').snapshots(),
                                builder: (context,snapshot){
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return Center(child: CircularProgressIndicator());
                                  }
                                  else{
                                    return new Text(snapshot.data.docs.length.toString(),
                                        style: TextStyle(
                                            color: constantColors.whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 28.0));
                                  }
                                }),
                            Text('Following',
                                style: TextStyle(
                                    color: constantColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: constantColors.darkColor,
                          borderRadius: BorderRadius.circular(15.0)),
                      height: 70.0,
                      width: 80.0,
                      child: Column(
                        children: [
                          Text('0',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0)),
                          Text('Posts',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget divider() {
    return Center(
      child: SizedBox(
        height: 25.0,
        width: 350.0,
        child: Divider(
          color: constantColors.whiteColor,
        ),
      ),
    );
  }

  Widget middleProfile(BuildContext context, dynamic snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150.0,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(FontAwesomeIcons.userAstronaut,
                      color: constantColors.yellowColor, size: 16),
                  Text('Recently Added',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: constantColors.whiteColor))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                child:StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('users').doc(
                        snapshot.data.data()['useruid']
                    ).collection('following').snapshots(),
                    builder: (context,snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      else{
                        return new ListView(
                        scrollDirection: Axis.horizontal,
                          children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator());
                            }
                            else{
                              return new Container(
                              height: 60.0,
                              width:60.0,
                              child: Image.network(documentSnapshot.data()['userimage']));
                            }
                        }).toList();
                     }
                    }),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: constantColors.darkColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            )
          ],
        ));

  }

  Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantColors.darkColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(5.0)),
        ));
  }

  logOutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: constantColors.darkColor,
            title: Text(
              'Log Out',
              style: TextStyle(
                  color: constantColors.whiteColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              MaterialButton(
                  child: Text(
                    'No',
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        decoration: TextDecoration.underline,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              MaterialButton(
                  color: constantColors.redColor,
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        decoration: TextDecoration.underline,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Provider.of<Authentication>(context, listen: false)
                        .logOutViaEmail()
                        .whenComplete(() {
                          Navigator.pushReplacement(context,
                            PageTransition(
                                child: Landingpage(),
                                type: PageTransitionType.bottomToTop)
                          );
                    });
                  })
            ],
          );
        });
  }

  CheckFollowingSheet(BuildContext context,dynamic snapshot){
    return showModalBottomSheet(context: context,builder: (context){
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: constantColors.blueGreyColor,
            borderRadius: BorderRadius.circular(12.0)),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(
                snapshot.data.data()['useruid']
            ).collection('following').snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else{
                return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else{
                    return new ListTile(
                      onTap: (){
                        Navigator.pushReplacement(context,PageTransition(
                            child:AltProfile(
                              userUid:
                              documentSnapshot.data()['useruid'],
                            ),
                            type: PageTransitionType.bottomToTop));
                      },
                      trailing: MaterialButton(
                        color: constantColors.blueColor,
                        child: Text('Unfollow',style:TextStyle(
                          color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        )),
                        onPressed: (){},
                      ),
                      leading: CircleAvatar(
                        backgroundColor: constantColors.darkColor,
                        backgroundImage: NetworkImage(
                          documentSnapshot.data()['userimage'],
                        ),
                      ),
                      title: Text(documentSnapshot.data()['username'],
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      subtitle: Text(
                        documentSnapshot.data()['useremail'],
                        style: TextStyle(
                            color: constantColors.yellowColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0),
                      ));
                  }
                }).toList();
            }
            }),
      );
    });
  }

  CheckFollowersSheet(BuildContext context,dynamic snapshot){
    return showModalBottomSheet(context: context,builder: (context){
      return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: constantColors.blueGreyColor,
            borderRadius: BorderRadius.circular(12.0)),
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').doc(
                snapshot.data.data()['useruid']
            ).collection('followers').snapshots(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator());
              }
              else{
                return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  else{
                    return new ListTile(
                        onTap: (){
                          Navigator.pushReplacement(context,PageTransition(
                              child:AltProfile(
                                userUid:
                                documentSnapshot.data()['useruid'],
                              ),
                              type: PageTransitionType.bottomToTop));
                        },
                        trailing: MaterialButton(
                          color: constantColors.blueColor,
                          child: Text('Unfollow',style:TextStyle(
                            color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                          onPressed: (){},
              ),
                        leading: CircleAvatar(
                          backgroundColor: constantColors.darkColor,
                          backgroundImage: NetworkImage(
                            documentSnapshot.data()['userimage'],
                          ),
                        ),
                        title: Text(documentSnapshot.data()['username'],
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        subtitle: Text(
                          documentSnapshot.data()['useremail'],
                          style: TextStyle(
                              color: constantColors.yellowColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0),
                        ));
                  }
                }).toList();
            }
            }),
      );
    });
  }
}
