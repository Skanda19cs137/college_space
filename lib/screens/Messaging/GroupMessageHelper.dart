import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Homepage/Homepage.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class GroupMessageHelper with ChangeNotifier {
  bool hasMemberJoined = false;
  bool get getHasMemmberJoined => hasMemberJoined;
  final ConstantColors constantColors = ConstantColors();
  showMessages(BuildContext context, DocumentSnapshot documentSnapshot,
      String adminUserUid) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(documentSnapshot.id)
            .collection('messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
                reverse: true,
                children: snapshot.data.docs
                    .map(((DocumentSnapshot documentSnapshot) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Stack(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 60.0, top: 20.0),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 120.0,
                                            child: Row(
                                              children: [
                                                Text(
                                                  (documentSnapshot.data()
                                                      as dynamic)['username'],
                                                  style: TextStyle(
                                                      color: constantColors
                                                          .greenColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12.0),
                                                ),
                                                Provider.of<Authentication>(
                                                                context,
                                                                listen: false)
                                                            .getUserUid ==
                                                        adminUserUid
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .chessKing,
                                                          color: constantColors
                                                              .lightBlueColor,
                                                          size: 12.0,
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 0.0,
                                                        height: 0.0,
                                                      )
                                              ],
                                            ),
                                          ),
                                          Text(
                                            (documentSnapshot.data()
                                                as dynamic)['message'],
                                            style: TextStyle(
                                              color: constantColors.whiteColor,
                                              fontSize: 14.0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Provider.of<Authentication>(
                                                      context,
                                                      listen: false)
                                                  .getUserUid ==
                                              (documentSnapshot.data()
                                                  as dynamic)['useruid']
                                          ? constantColors.blueGreyColor
                                              .withOpacity(0.7)
                                          : constantColors.blueGreyColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              child: Provider.of<Authentication>(context,
                                              listen: false)
                                          .getUserUid ==
                                      (documentSnapshot.data()
                                          as dynamic)['useruid']
                                  ? Container(
                                      child: Column(
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: constantColors.blueColor,
                                                size: 16.0,
                                              ),
                                              onPressed: () {}),
                                          IconButton(
                                              icon: Icon(Icons.delete_rounded,
                                                  color:
                                                      constantColors.redColor,
                                                  size: 16.0),
                                              onPressed: () {})
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 0.0,
                                      height: 0.0,
                                    )),
                          Positioned(
                              left: 40.0,
                              child: Provider.of<Authentication>(context,
                                              listen: false)
                                          .getUserUid ==
                                      (documentSnapshot.data()
                                          as dynamic)['useruid']
                                  ? Container(
                                      height: 0.0,
                                      width: 0.0,
                                    )
                                  : CircleAvatar(
                                      backgroundColor: constantColors.darkColor,
                                      backgroundImage: NetworkImage(
                                          (documentSnapshot.data()
                                              as dynamic)['userimage']),
                                    ))
                        ],
                      ),
                    ),
                  );
                })).toList());
          }
        });
  }

  sendMessage(BuildContext context, DocumentSnapshot documentSnapshot,
      TextEditingController messageController) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(documentSnapshot.id)
        .collection('messages')
        .add({
      'message': messageController.text,
      'time': Timestamp.now(),
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'useruid': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserName,
      'useruid': Provider.of<FirebaseOperations>(context, listen: false)
          .getInitUserImage,
    });
  }

  Future checkIfJoined(BuildContext context, String chatroomName,
      String chatroomAdminUid) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc('chatroomName')
        .collection('members')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((value) {
      hasMemberJoined = false;
      print('initial state => $hasMemberJoined');
      if (value.data()['joined'] != null) {
        hasMemberJoined = value.data()['joined'];
        notifyListeners();
      }
      print('final state => $hasMemberJoined');
      if (Provider.of<Authentication>(context, listen: false).getUserUid ==
          chatroomAdminUid) {
        hasMemberJoined = true;
        notifyListeners();
      }
    });
  }

  askToJoin(BuildContext context, String roomName) {
    return showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            backgroundColor: constantColors.darkColor,
            title: Text(
              'Join $roomName ?',
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
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: Homepage(),
                            type: PageTransitionType.bottomToTop));
                  }),
              MaterialButton(
                  color: constantColors.blueColor,
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      color: constantColors.blueColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    FirebaseFirestore.instance
                        .collection('chatrooms')
                        .doc(roomName)
                        .collection('members')
                        .doc(Provider.of<Authentication>(context, listen: false)
                            .getUserUid)
                        .set({
                      'joined': true,
                      'username': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserName,
                      'userimage': Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getInitUserImage,
                      'username':
                          Provider.of<Authentication>(context, listen: false)
                              .getUserUid,
                      'time': Timestamp.now()
                    }).whenComplete(() {
                      Navigator.pop(context);
                    });
                  })
            ],
          );
        });
  }
}
