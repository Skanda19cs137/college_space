import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Homepage/Homepage.dart';
import 'package:college_space/screens/Messaging/GroupMessageHelper.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class GroupMessage extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  GroupMessage({@required this.documentSnapshot});

  @override
  State<GroupMessage> createState() => _GroupMessageState();
}

class _GroupMessageState extends State<GroupMessage> {
  final ConstantColors constantColors = ConstantColors();

  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    Provider.of<GroupMessageHelper>(context, listen: false)
        .checkIfJoined(context, widget.documentSnapshot.id,
            widget.documentSnapshot.get('useruid'))
        .whenComplete(() async {
      if (Provider.of<GroupMessageHelper>(context, listen: false)
          .getHasMemmberJoined) {
        Timer(
            Duration(microseconds: 10),
            () => Provider.of<GroupMessageHelper>(context, listen: false)
                .askToJoin(context, widget.documentSnapshot.id));
      }
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      appBar: AppBar(
        actions: [
          Provider.of<Authentication>(context, listen: false).getUserUid ==
                  widget.documentSnapshot.get('useruid')
              ? IconButton(
                  icon: Icon(
                    EvaIcons.moreVertical,
                    color: constantColors.whiteColor,
                  ),
                  onPressed: () {},
                )
              : Container(
                  width: 0.0,
                  height: 0.0,
                ),
          IconButton(
            icon: Icon(
              EvaIcons.logOut,
              color: constantColors.redColor,
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: constantColors.whiteColor),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: Homepage(), type: PageTransitionType.bottomToTop));
          },
        ),
        backgroundColor: constantColors.darkColor.withOpacity(0.6),
        title: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: constantColors.darkColor,
                backgroundImage: NetworkImage(
                    widget.documentSnapshot.get('roomavatar')),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.documentSnapshot.get('roomname'),
                      style: TextStyle(
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chatrooms')
                            .doc(widget.documentSnapshot.id)
                            .collection('members')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return new Text(
                                '${snapshot.data.docs.length.toString()}',
                                style: TextStyle(
                                    color: constantColors.greyColor
                                        .withOpacity(0.75),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0));
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                child: Provider.of<GroupMessageHelper>(context, listen: false)
                    .showMessages(context, widget.documentSnapshot,
                        widget.documentSnapshot.get('useruid')),
                curve: Curves.easeIn,
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<GroupMessageHelper>(context,
                                    listen: false)
                                .showSticker(
                                    context, widget.documentSnapshot.id);
                          },
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundColor: constantColors.transperant,
                            backgroundImage:
                                AssetImage('assets/icons/sunflower.png'),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: TextField(
                            controller: messageController,
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: 'Type Message',
                              hintStyle: TextStyle(
                                  color:
                                      constantColors.greyColor.withOpacity(0.5),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                            backgroundColor: constantColors.greenColor,
                            child: Icon(
                              Icons.send_rounded,
                              color: constantColors.whiteColor,
                            ),
                            onPressed: () {
                              if (messageController.text.isNotEmpty) {
                                Provider.of<GroupMessageHelper>(context,
                                        listen: false)
                                    .sendMessage(
                                        context,
                                        widget.documentSnapshot,
                                        messageController);
                              }
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
