import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Homepage/Homepage.dart';
import 'package:college_space/services/Authentication.dart';
<<<<<<< HEAD
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

=======
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'landingUtils.dart';

>>>>>>> origin/master
class LandingService with ChangeNotifier {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
<<<<<<< HEAD
=======

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: constantColors.transperant,
                  backgroundImage: FileImage(
                      Provider.of<landingUtils>(context, listen: false)
                          .userAvatar),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                          child: Text('Reselect',
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationColor: constantColors.whiteColor)),
                          onPressed: () {
                            Provider.of<landingUtils>(context, listen: false)
                                .pickUserAvatar(context, ImageSource.gallery);
                          }),
                      MaterialButton(
                          color: constantColors.blueColor,
                          child: Text('Confirm Image',
                              style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              )),
                          onPressed: () {
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .uploadUserAvatar(context)
                                .whenComplete(() {
                              signUpSheet(context);
                            });
                          }),
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        });
  }

>>>>>>> origin/master
  Widget passwordlessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
<<<<<<< HEAD
          stream: FirebaseFirestore.instance.collection('allUsers').snapshots(),
=======
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
>>>>>>> origin/master
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot documentSnapshot) {
                  return ListTile(
                    leading: CircleAvatar(
<<<<<<< HEAD
                      backgroundImage:
                          NetworkImage((documentSnapshot.data() as dynamic)!['userimage']),
=======
                      backgroundColor: constantColors.transperant,
                      backgroundImage: NetworkImage(
                          (documentSnapshot.data() as dynamic)!['userimage']),
>>>>>>> origin/master
                    ),
                    title: Text(
                      (documentSnapshot.data() as dynamic)!['username'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                    ),
                    subtitle: Text(
                      (documentSnapshot.data() as dynamic)!['useremail'],
                      style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.trashAlt,
                        color: constantColors.redColor,
                      ),
                      onPressed: () {},
                    ),
                  );
                }).toList(),
              );
            }
          }),
    );
  }

<<<<<<< HEAD

  logInSheet(BuildContext context){
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
=======
  logInSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
>>>>>>> origin/master
            child: Container(
              decoration: BoxDecoration(
                  color: constantColors.darkColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
<<<<<<< HEAD
                  )
              ),
              height: MediaQuery.of(context).size.height*0.35 ,
=======
                  )),
              height: MediaQuery.of(context).size.height * 0.35,
>>>>>>> origin/master
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
<<<<<<< HEAD
                    child:TextField(
=======
                    child: TextField(
>>>>>>> origin/master
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter name ... ',
                        hintStyle: TextStyle(
<<<<<<< HEAD
                            color:  constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      ),
                      style:TextStyle(
                          color:  constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ) ,
=======
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
>>>>>>> origin/master
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
<<<<<<< HEAD
                    child:TextField(
=======
                    child: TextField(
>>>>>>> origin/master
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter email ... ',
                        hintStyle: TextStyle(
<<<<<<< HEAD
                            color:  constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      ),
                      style:TextStyle(
                          color:  constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ) ,
=======
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
>>>>>>> origin/master
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
<<<<<<< HEAD
                    child:TextField(
=======
                    child: TextField(
>>>>>>> origin/master
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Enter password ... ',
                        hintStyle: TextStyle(
<<<<<<< HEAD
                            color:  constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      ),
                      style:TextStyle(
                          color:  constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ) ,
=======
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
>>>>>>> origin/master
                    ),
                  ),
                  FloatingActionButton(
                      backgroundColor: constantColors.blueColor,
<<<<<<< HEAD
                      child: Icon(FontAwesomeIcons.check , color: constantColors.whiteColor,),
                      onPressed: (){
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context,listen:false).logIntoAccount(userEmailController.text, userPasswordController.text).whenComplete((){
                            Navigator.pushReplacement(context, PageTransition(
                                child: Homepage(),
                                type: PageTransitionType.bottomToTop));
                          });
                        }
                        else{
=======
                      child: Icon(
                        FontAwesomeIcons.check,
                        color: constantColors.whiteColor,
                      ),
                      onPressed: () {
                        if (userEmailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .logIntoAccount(userEmailController.text,
                                  userPasswordController.text)
                              .whenComplete(() {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Homepage(),
                                    type: PageTransitionType.bottomToTop));
                          });
                        } else {
>>>>>>> origin/master
                          warningText(context, 'Fill all the details');
                        }
                      }),
                ],
              ),
            ),
          );
<<<<<<< HEAD
        }
    );
  }




=======
        });
  }

>>>>>>> origin/master
  signUpSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
<<<<<<< HEAD
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height*0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: constantColors.darkColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
=======
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0)),
>>>>>>> origin/master
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  CircleAvatar(
<<<<<<< HEAD
=======
                    backgroundImage: FileImage(
                        Provider.of<landingUtils>(context, listen: false)
                            .getUserAvatar),
>>>>>>> origin/master
                    backgroundColor: constantColors.greyColor,
                    radius: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
<<<<<<< HEAD
                    child:TextField(
                        controller: userNameController,
                        decoration: InputDecoration(
                          hintText: 'Enter name ... ',
                          hintStyle: TextStyle(
                            color:  constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                          ),
                        ),
                        style:TextStyle(
                            color:  constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                        ) ,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child:TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter email ... ',
                        hintStyle: TextStyle(
                            color:  constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      ),
                      style:TextStyle(
                          color:  constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ) ,
=======
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter name ... ',
                        hintStyle: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
>>>>>>> origin/master
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
<<<<<<< HEAD
                    child:TextField(
=======
                    child: TextField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter email ... ',
                        hintStyle: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
>>>>>>> origin/master
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Enter password ... ',
                        hintStyle: TextStyle(
<<<<<<< HEAD
                            color:  constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      ),
                      style:TextStyle(
                          color:  constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ) ,
=======
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
>>>>>>> origin/master
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: FloatingActionButton(
<<<<<<< HEAD
                      backgroundColor: constantColors.redColor,
                        child: Icon(FontAwesomeIcons.check , color: constantColors.whiteColor,),
                        onPressed: (){
                         if (userEmailController.text.isNotEmpty) {
                           Provider.of<Authentication>(context,listen:false).createAccount(userEmailController.text, userPasswordController.text)
                               .whenComplete((){
                             Navigator.pushReplacement(context, PageTransition(
                                 child: Homepage(),
                                 type: PageTransitionType.bottomToTop));
                           });
                         }
                         else{
                           warningText(context, 'Fill all the details');
                         }
=======
                        backgroundColor: constantColors.redColor,
                        child: Icon(
                          FontAwesomeIcons.check,
                          color: constantColors.whiteColor,
                        ),
                        onPressed: () {
                          if (userEmailController.text.isNotEmpty) {
                            Provider.of<Authentication>(context, listen: false)
                                .createAccount(userEmailController.text,
                                    userPasswordController.text)
                                .whenComplete(() {
                              print('Creating collection...');
                              Provider.of<FirebaseOperations>(context,
                                      listen: false)
                                  .createUserCollection(context, {
                                'useruid': Provider.of<Authentication>(context,
                                        listen: false)
                                    .getUserUid,
                                'useremail': userEmailController.text,
                                'username': userNameController.text,
                                'userImage': Provider.of<landingUtils>(context,
                                        listen: false)
                                    .getUserAvatarUrl,
                              });
                            }).whenComplete(() {
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: Homepage(),
                                      type: PageTransitionType.bottomToTop));
                            });
                          } else {
                            warningText(context, 'Fill all the details');
                          }
>>>>>>> origin/master
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

<<<<<<< HEAD
  warningText(BuildContext context, String warning)
  {
    return showModalBottomSheet(context: context,
        builder: (context){
          return Container(
            decoration: BoxDecoration(
              color: constantColors.darkColor,
              borderRadius: BorderRadius.circular(15.0)
            ),
            height: MediaQuery.of(context).size.height*0.12 ,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(warning,
              style: TextStyle(color: constantColors.whiteColor, fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
    );
=======
  warningText(BuildContext context, String warning) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.circular(15.0)),
            height: MediaQuery.of(context).size.height * 0.12,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                warning,
                style: TextStyle(
                    color: constantColors.whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        });
>>>>>>> origin/master
  }
}
