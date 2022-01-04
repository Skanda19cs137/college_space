import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/AltProfile/alt_profile.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostFunctions with ChangeNotifier {
  TextEditingController commentController = TextEditingController();
  ConstantColors constantColors = ConstantColors();
  String imageTimePosted;
  String get getImageTimePosted => imageTimePosted;
  TextEditingController updatedCaptionController = TextEditingController();
  showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    imageTimePosted = timeago.format(dateTime);
    notifyListeners();
  }

  showPostOption(BuildContext context, String postId) {
    return showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        color: constantColors.blueColor,
                        child: Text('Edit Caption',
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Center(
                                      child: Row(
                                    children: [
                                      Container(
                                        width: 300.0,
                                        height: 50.0,
                                        child: TextField(
                                          decoration: InputDecoration(
                                              hintText: 'Add New Caption',
                                              hintStyle: TextStyle(
                                                  color:
                                                      constantColors.whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0)),
                                          style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                          controller: updatedCaptionController,
                                        ),
                                      ),
                                      FloatingActionButton(
                                          backgroundColor:
                                              constantColors.redColor,
                                          child: Icon(
                                            FontAwesomeIcons.fileUpload,
                                            color: constantColors.whiteColor,
                                          ),
                                          onPressed: () {
                                            Provider.of<FirebaseOperations>(
                                                    context,
                                                    listen: false)
                                                .updateCaption(postId, {
                                              'caption':
                                                  updatedCaptionController.text
                                            });
                                          })
                                    ],
                                  )),
                                );
                              });
                        },
                      ),
                      MaterialButton(
                        color: constantColors.redColor,
                        child: Text('Delete Caption',
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: constantColors.darkColor,
                                  title: Text('Delete This Post? ',
                                      style: TextStyle(
                                          color: constantColors.whiteColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold)),
                                  actions: [
                                    MaterialButton(
                                      child: Text('No',
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  constantColors.whiteColor,
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    MaterialButton(
                                      color: constantColors.redColor,
                                      child: Text('Yes',
                                          style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0)),
                                      onPressed: () {
                                        Provider.of<FirebaseOperations>(context,
                                                listen: false)
                                            .deleteUserData(postId, 'posts')
                                            .whenComplete(
                                                () => Navigator.pop(context));
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                    ],
                  ))
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0)),
              ),
            ),
          );
        });
  }

  Future addLike(BuildContext context, String postId, subDocId) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(subDocId)
        .set({
      'likes': FieldValue.increment(1),
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
      'useremail': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserEmail,
      'time': Timestamp.now()
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
      'useremail': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserEmail,
      'time': Timestamp.now()
    });
  }

  showAwardsPresenter(BuildContext context,String postID){
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context){
        return Container(
        height: MediaQuery.of(context).size.height * 0.5,
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
            Container(
              width: 200.0,
              decoration: BoxDecoration(
                  border: Border.all(color: constantColors.whiteColor),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Center(
                child: Text('Award Socialities',
                    style: TextStyle(
                        color: constantColors.blueColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
              ),
            ),
        Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('awards')
            .orderBy('time')
            .snapshots(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
            child: CircularProgressIndicator()
            );
        }
          else{
            return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot){
              return ListTile(
                leading: GestureDetector(
                  onTap: (){
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: AltProfile(
                              userUid: documentSnapshot.data()['useruid'],
                            ),
                            type: PageTransitionType.bottomToTop));
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      documentSnapshot.data()['userimage']
                    ),
                    radius: 15.0,
                    backgroundColor: constantColors.darkColor,
                  ),
                ),
                trailing: Provider.of<Authentication>(context,
                    listen: false)
                    .getUserUid ==
                    documentSnapshot.get('useruid')
                    ? Container(
                  width: 0.0,
                  height: 0.0,
                )
                    : MaterialButton(
                    child: Text(
                      'Follow',
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0),
                    ),
                    onPressed: () {},
                    color: constantColors.blueColor),
                title: Text(
                  documentSnapshot.data()['username'],
                  style: Textstyle(
                    color: constantColors.blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
                ),
              );
        }).toList()
            );
        }
        },
        ))
          ],
        ),
        decoration: BoxDecoration(
          color: constantColors.blueGreyColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0)),
        )
        );
      });
  }

  showCommentsSheet(
      BuildContext context, DocumentSnapshot snapshot, String docId) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
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
                    Container(
                      width: 100.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: constantColors.whiteColor),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Center(
                        child: Text('Comments',
                            style: TextStyle(
                                color: constantColors.blueColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.61,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('posts')
                              .doc(docId)
                              .collection('comments')
                              .orderBy('time')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return new ListView(
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot documentSnapshot) {
                                return Container(
                                  /* color: constantColors.redColor,*/
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: (){
                                                Navigator.pushReplacement(
                                                    context,
                                                    PageTransition(
                                                        child: AltProfile(
                                                          userUid: documentSnapshot.data()['useruid'],
                                                        ),
                                                        type: PageTransitionType.bottomToTop));
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: constantColors
                                                    .blueGreyColor,
                                                radius: 15.0,
                                                backgroundImage: NetworkImage(
                                                    documentSnapshot.get('userimage')),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Container(
                                                child: Text(
                                              documentSnapshot.get('username'),
                                              style: TextStyle(
                                                  color:
                                                      constantColors.whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0),
                                            )),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      FontAwesomeIcons.arrowUp,
                                                      color: constantColors
                                                          .blueColor,
                                                      size: 14.0,
                                                    ),
                                                    onPressed: () {}),
                                                Text(
                                                  '0',
                                                  style: TextStyle(
                                                      color: constantColors
                                                          .whiteColor,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                IconButton(
                                                    icon: Icon(
                                                        FontAwesomeIcons.reply,
                                                        color: constantColors
                                                            .yellowColor,
                                                        size: 12),
                                                    onPressed: () {}),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color:
                                                      constantColors.blueColor,
                                                  size: 12,
                                                ),
                                                onPressed: () {}),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Text(
                                                documentSnapshot.get('comment'),
                                                style: TextStyle(
                                                    color: constantColors
                                                        .whiteColor,
                                                    fontSize: 16.0),
                                              ),
                                            ),
                                            IconButton(
                                                icon: Icon(
                                                    FontAwesomeIcons.trashAlt,
                                                    color:
                                                        constantColors.redColor,
                                                    size: 16),
                                                onPressed: () {}),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList());
                            }
                          },
                        )),
                    Container(
                      /* color: constantColors.redColor,*/
                      width: 400,
                      height: 50.0,
                      /*
                      width: MediaQuery.of(context).size.width,
                      */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 300.0,
                            height: 20.0,
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                  hintText: 'Add Comments.....',
                                  hintStyle: TextStyle(
                                      color: constantColors.whiteColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              controller: commentController,
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          FloatingActionButton(
                              backgroundColor: constantColors.greenColor,
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: constantColors.whiteColor,
                              ),
                              onPressed: () {
                                print('Adding Comment....');
                                addComment(
                                        context,
                                        snapshot.get('caption'),
                                        commentController.text)
                                    .whenComplete(() {
                                  commentController.clear();
                                  notifyListeners();
                                });
                              })
                        ],
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: constantColors.blueGreyColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0)))),
          );
        });
  }

  showLikes(BuildContext context, String postId) {
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
                Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.whiteColor),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text('Likes',
                        style: TextStyle(
                            color: constantColors.blueColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .collection('likes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return new ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot documentSnapshot) {
                          return ListTile(
                            leading: GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                    child: AltProfile(
                                        userUid: documentSnapshot.data()['useruid'],
                                    ),
                                    type: PageTransitionType.bottomToTop));
                              },
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(documentSnapshot
                                    .get('userimage')),
                              ),
                            ),
                            title: Text(
                              documentSnapshot.get('username'),
                              style: TextStyle(
                                  color: constantColors.blueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                            ),
                            subtitle: Text(
                              documentSnapshot.get('useremail'),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0),
                            ),
                            trailing: Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserUid ==
                                    documentSnapshot.get('useruid')
                                ? Container(
                                    width: 0.0,
                                    height: 0.0,
                                  )
                                : MaterialButton(
                                    child: Text(
                                      'Follow',
                                      style: TextStyle(
                                          color: constantColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                    ),
                                    onPressed: () {},
                                    color: constantColors.blueColor),
                          );
                        }).toList());
                      }
                    },
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0)),
            ),
          );
        });
  }

  showReward(BuildContext context, String postId) {
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
                Container(
                  width: 100.0,
                  decoration: BoxDecoration(
                      border: Border.all(color: constantColors.whiteColor),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text('Rewards',
                        style: TextStyle(
                            color: constantColors.blueColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('awards')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot documentsnapshot) {
                                return GestureDetector(
                                  onTap: () async {
                                    print(documentsnapshot.get('image'));
                                    await Provider.of<FirebaseOperations>(
                                            context,
                                            listen: false)
                                        .addAward(postId, {
                                      'username':
                                          Provider.of<FirebaseOperations>(
                                                  context,
                                                  listen: false)
                                              .getInitUserName,
                                      'userimage':
                                          Provider.of<FirebaseOperations>(
                                                  context,
                                                  listen: false)
                                              .getInitUserImage,
                                      'useruid': Provider.of<Authentication>(
                                              context,
                                              listen: false)
                                          .getUserUid,
                                      'time': Timestamp.now(),
                                      'award': documentsnapshot.get('image')
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      height: 50.0,
                                      width: 50.0,
                                      child: Image.network(documentsnapshot
                                          .get('image')),
                                    ),
                                  ),
                                );
                              }).toList());
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0))),
          );
        });
  }
}
