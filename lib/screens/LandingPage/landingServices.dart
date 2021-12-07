import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Homepage/Homepage.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LandingService with ChangeNotifier {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
  Widget passwordlessSignIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('allUsers').snapshots(),
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
                      backgroundImage:
                          NetworkImage((documentSnapshot.data() as dynamic)!['userimage']),
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


  logInSheet(BuildContext context){
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                  color: constantColors.darkColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  )
              ),
              height: MediaQuery.of(context).size.height*0.35 ,
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child:TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Enter password ... ',
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
                  FloatingActionButton(
                      backgroundColor: constantColors.blueColor,
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
                          warningText(context, 'Fill all the details');
                        }
                      }),
                ],
              ),
            ),
          );
        }
    );
  }




  signUpSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height*0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: constantColors.darkColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0)),
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
                    backgroundColor: constantColors.greyColor,
                    radius: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child:TextField(
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Enter password ... ',
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
                    padding: const EdgeInsets.only(top: 10.0),
                    child: FloatingActionButton(
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
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

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
  }
}
