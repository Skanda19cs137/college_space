import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/AltProfile/alt_profile.dart';
import 'package:college_space/screens/UploadPost/uploadPost.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/utils/PostOptions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class FeedHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

  Widget feedAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: constantColors.darkColor.withOpacity(0.6),
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.add_box,
              color: constantColors.greenColor,
            ),
            onPressed: () {
              Provider.of<UploadPost>(context, listen: false)
                  .selectPostImageType(context);
            })
      ],
      title: RichText(
        text: TextSpan(
            text: 'College Space',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
            children: <TextSpan>[
              TextSpan(
                  text: 'Feed',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0))
            ]),
      ),
    );
  }

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('posts').orderBy('time',descending: true).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    height: 500.0,
                    width: 400.0,
                    child: Lottie.asset("assets/animations/loading.json"),
                  ),
                );
              } else {
                return loadPosts(context, snapshot);
              }
            },
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: constantColors.darkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0))),
        ),
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView(
      children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
        Provider.of<PostFunctions>(context,listen: false).showTimeAgo(documentSnapshot.get('time'));
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(documentSnapshot.get('useruid')!=Provider.of<Authentication>(context,listen: false).getUserUid){
                          Navigator.pushReplacement(context,
                              PageTransition(child: AltProfile(userUid: documentSnapshot.get('useruid'),), type: PageTransitionType.leftToRight));
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: constantColors.transperant,
                        radius: 20.0,
                        backgroundImage: ((documentSnapshot.data()
                                    as dynamic)['userimage'] !=
                                null)
                            ? NetworkImage((documentSnapshot.data()
                                as dynamic)['userimage'])
                            : AssetImage('assets/images/empty.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                  documentSnapshot.get('caption'),
                                  style: TextStyle(
                                      color: constantColors.greenColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0)),
                            ),
                            Container(
                                child: RichText(
                              text: TextSpan(
                                  text: (documentSnapshot.data()
                                      as dynamic)['username'],
                                  style: TextStyle(
                                      color: constantColors.blueColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ',${Provider.of<PostFunctions>(context,listen: false).getImageTimePosted.toString()}',
                                        style: TextStyle(
                                            color: constantColors.lightColor))
                                  ]),
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: FittedBox(
                    child: ((documentSnapshot.data() as dynamic)['postimage'] !=
                            null)
                        ? Image.network(
                            (documentSnapshot.data() as dynamic)['postimage'],
                            scale: 2)
                        : AssetImage('assets/images/empty.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showLikes(
                                        context,
                                        documentSnapshot.get('postid'));
                              },
                              onTap: () {
                                print('Adding like....');
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .addLike(
                                        context,
                                        documentSnapshot.get('postid'),
                                        Provider.of<Authentication>(context,
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
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                          snapshot.data.docs.length.toString(),
                                          style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showCommentsSheet(
                                        context,
                                        documentSnapshot,
                                        documentSnapshot.get('postid'));
                              },
                              child: Icon(
                                FontAwesomeIcons.comment,
                                color: constantColors.greenColor,
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
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                      Container(
                        width: 80.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onLongPress: (){
                                Provider.of<PostFunctions>(context,
                                        listen: false).showAwardsPresenter(context,
                                                documentSnapshot.get('postid'));
                                },
                              onTap: () {
                                Provider.of<PostFunctions>(context,
                                        listen: false)
                                    .showReward(
                                        context,
                                        documentSnapshot.get('postid'));
                              },
                              child: Icon(
                                FontAwesomeIcons.award,
                                color: constantColors.yellowColor,
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
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0)),
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                      Spacer(),
                      Provider.of<Authentication>(context, listen: false)
                                  .getUserUid ==
                              (documentSnapshot.data() as dynamic)['useruid']
                          ? IconButton(
                              icon: Icon(
                                EvaIcons.moreVertical,
                                color: constantColors.whiteColor,
                              ),
                              onPressed: () {
                                Provider.of<PostFunctions>(context,listen: false).showPostOption(context,documentSnapshot.get('postid'));
                              },
                            )
                          : Container(
                              width: 0.0,
                              height: 0.0,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
