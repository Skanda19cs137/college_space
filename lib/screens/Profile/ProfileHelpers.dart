import 'package:js/js.dart';
import 'package:universal_html/html.dart';
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
              color: constantColors.redColor,
              height: 220.0,
              width: 180.0,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                          backgroundColor: constantColors.transperant,
                          radius: 60.0,
                          backgroundImage:
                              NetworkImage(snapshot.data.data()['userimage']))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snapshot.data.data()['username'],
                        style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(EvaIcons.email,
                            color: constantColors.greenColor, size: 16.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(snapshot.data.data()['username'],
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              color: constantColors.yellowColor,
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.only(top: 16.0)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
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
                              Text('Followers',
                                  style: TextStyle(
                                      color: constantColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0)),
                            ],
                          )),
                      Container(
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
    return Padding(
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
          child: Image.asset('assets/images/empty.png'),
          height: MediaQuery.of(context).size.height * 0.53,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantColors.darkColor.withOpacity(0.4),
              borderRadius: BorderRadius.circular(5.0)),
        ));
  }

  void logOutDialog(BuildContext context) {}
}
