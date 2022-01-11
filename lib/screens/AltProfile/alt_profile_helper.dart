import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/AltProfile/alt_profile.dart';
import 'package:college_space/screens/Homepage/Homepage.dart';
import 'package:college_space/screens/Profile/ProfileHelpers.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:college_space/utils/PostOptions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AltProfileHelper with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded,
            color: constantColors.whiteColor),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: Homepage(), type: PageTransitionType.topToBottom));
        },
      ),
      backgroundColor: constantColors.blueGreyColor.withOpacity(0.7),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(EvaIcons.moreVertical, color: constantColors.whiteColor),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: Homepage(), type: PageTransitionType.topToBottom));
          },
        ),
      ],
      title: RichText(
        text: TextSpan(
            text: 'College',
            style: TextStyle(
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            children: <TextSpan>[
              TextSpan(
                text: 'Space',
                style: TextStyle(
                    color: constantColors.blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )
            ]),
      ),
    );
  }

  Widget headerProfile(BuildContext context,
      AsyncSnapshot<DocumentSnapshot> snapshot, String userUid) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.37,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
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
                              backgroundImage: (snapshot.data.get('userimage')!=
                                  null)
                                  ? NetworkImage(snapshot.data.get('userimage'))
                                  : AssetImage('assets/images/empty.png'))),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(snapshot.data.get('username'),
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
                              child: Text(
                                snapshot.data.get('useremail'),
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
                              onTap: () {
                                CheckFollowersSheet(context, snapshot);
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
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(snapshot.data.get('useruid'))
                                            .collection('followers')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child: CircularProgressIndicator());
                                          } else {
                                            return new Text(
                                                snapshot.data.docs.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    constantColors.whiteColor,
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
                              )),
                          GestureDetector(
                              onTap: () {
                                //CheckFollowingSheet(context, snapshot);
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
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(snapshot.data.get('useruid'))
                                            .collection('following')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child: CircularProgressIndicator());
                                          } else {
                                            return new Text(
                                                snapshot.data.docs.length
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                    constantColors.whiteColor,
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
                              )),
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
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.05,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: (){
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .followUser(
                          followingUid: userUid,
                          followingDocId: Provider.of<Authentication>(context,
                              listen: false)
                              .getUserUid,
                          followingData: {
                            'username': Provider.of<FirebaseOperations>(context,
                                listen: false)
                                .getInitUserName,
                            'userimage': Provider.of<FirebaseOperations>(
                                context,
                                listen: false)
                                .getInitUserImage,
                            'useruid': Provider.of<Authentication>(context,
                                listen: false)
                                .getUserUid,
                            'useremail': Provider.of<FirebaseOperations>(
                                context,
                                listen: false)
                                .getInitUserEmail,
                            'time': Timestamp.now(),
                          },
                          followerUid: Provider.of<Authentication>(context,
                              listen: false)
                              .getUserUid,
                          followerDocId: userUid,
                          followerData: {
                            'username': snapshot.data.get('username'),
                            'userimage': snapshot.data.get('userimage'),
                            'useremail': snapshot.data.get('useremail'),
                            'useruid': snapshot.data.get('useruid'),
                            'time': Timestamp.now(),
                          })
                          .whenComplete(() {
                        followedNotification(
                            context, snapshot.data.get('username'),'Followed');
                      });
                    },
                    color: constantColors.blueColor,
                    child: Text('Follow',
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: (){},
                    color: constantColors.blueColor,
                    child: Text('Message',
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
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

  Widget footerProfile(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: constantColors.darkColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.data.get('useruid') )
                .collection('posts')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return new GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  children: snapshot.data.docs.map((DocumentSnapshot snapshot) {
                    return GestureDetector(
                      onTap: () {
                         showPostDetails(
                             context: context, documentSnapshot: snapshot);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * .8,
                        width: MediaQuery.of(context).size.width,
                        child: FittedBox(
                          child: Image.network(snapshot['postimage']),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  followedNotification(BuildContext context, String name,String data) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  Text('$data $name',
                      style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ))
                ],
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }

  CheckFollowersSheet(BuildContext context, dynamic snapshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(snapshot.data.data()['useruid'])
                    .collection('followers')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return new ListView(
                        children: snapshot.data.docs
                            .map((DocumentSnapshot documentSnapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return new ListTile(
                            onTap: () {
                              if (documentSnapshot.get('useruid') !=
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .getUserUid) {
                                Navigator.pushReplacement(
                                    (context),
                                    PageTransition(
                                        child: AltProfile(
                                          userUid:
                                              documentSnapshot.get('useruid'),
                                        ),
                                        type: PageTransitionType.leftToRight));
                              }
                            },

                            leading: CircleAvatar(
                              backgroundColor: constantColors.darkColor,
                              backgroundImage: NetworkImage(
                                documentSnapshot.get('userimage'),
                              ),
                            ),
                            title: Text(
                              documentSnapshot.get('username'),
                              style: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            subtitle: Text(
                              documentSnapshot.get('useremail'),
                              style: TextStyle(
                                  color: constantColors.yellowColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0),
                            ));
                      }
                    }).toList());
                  }
                }),
          );
        });
  }

  showPostDetails({BuildContext context, DocumentSnapshot documentSnapshot}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.63,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.darkColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child:
                      Image.network(documentSnapshot.get('postimage')),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  documentSnapshot.get('caption'),
                  style: TextStyle(
                    color: constantColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 64.0),
                        child: Container(
                          height: 40,
                          width: 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  Provider.of<PostFunctions>(context,
                                      listen: false)
                                      .showLikes(
                                      context, documentSnapshot
                                      .get('postid'));
                                },
                                onTap: () {
                                  print('Added Like');
                                  Provider.of<PostFunctions>(context,
                                      listen: false)
                                      .addLike(
                                      context,
                                      documentSnapshot.get('postid'),
                                      Provider.of<Authentication>(
                                          context,
                                          listen: false)
                                          .getUserUid);
                                },
                                child: Icon(
                                  FontAwesomeIcons.heart,
                                  color: constantColors.redColor,
                                  size: 22,
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(documentSnapshot.get('postid'))
                                    .collection('likes')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        snapshot.data.docs.length.toString(),
                                        style: TextStyle(
                                          color: constantColors.whiteColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Provider.of<PostFunctions>(context,
                                    listen: false)
                                    .showCommentsSheet(
                                    context, documentSnapshot,
                                    documentSnapshot.get('postid'));
                              },
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: constantColors.yellowColor,
                                size: 22,
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('posts')
                                  .doc(documentSnapshot.get('postid'))
                                  .collection('comments')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      snapshot.data.docs.length.toString(),
                                      style: TextStyle(
                                        color: constantColors.whiteColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onLongPress: () {
                                  Provider.of<PostFunctions>(context,
                                      listen: false)
                                      .showAwardsPresenter(
                                      context, documentSnapshot
                                      .get('postid'));
                                },
                                onTap: () {
                                  Provider.of<PostFunctions>(context,
                                      listen: false)
                                      .showReward(
                                      context, documentSnapshot
                                      .get('postid'));
                                },
                                child: Icon(
                                  FontAwesomeIcons.award,
                                  color: constantColors.greenColor,
                                  size: 22,
                                ),
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('posts')
                                    .doc(documentSnapshot.get('postid'))
                                    .collection('awards')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        snapshot.data.docs.length.toString(),
                                        style: TextStyle(
                                          color: constantColors.whiteColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Provider.of<Authentication>(context, listen: false)
                          .getUserUid ==
                          documentSnapshot.get('useruid')
                          ? IconButton(
                        icon: Icon(EvaIcons.moreVertical,
                            color: constantColors.whiteColor),
                        onPressed: () {
                          Provider.of<PostFunctions>(context,
                              listen: false)
                              .showPostOption(
                              context,
                              documentSnapshot.get('postid'));
                        },
                      )
                          : Container(
                        width: 0.0,
                        height: 0.0,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }



}
