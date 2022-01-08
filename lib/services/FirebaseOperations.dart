import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:js/js.dart';
import 'package:universal_html/html.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/screens/LandingPage/LandingUtil.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;
  String initUserEmail;
  String initUserName;
  String initUserImage;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String get getInitUserName {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser.uid)
        .get()
      ..then((docu) {
        initUserName = docu.data()['username'];
      });
    return initUserName;
  }

  String get getInitUserEmail {
    return firebaseAuth.currentUser.email;
  }

  String get getInitUserImage {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseAuth.currentUser.uid)
        .get()
      ..then((doc) {
        initUserImage = doc.data()['userimage'];
      });
    return initUserImage;
  }

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');
    imageUploadTask = imageReference.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask.whenComplete(() {
      print('Image Uploaded!');
    });

    imageReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          'The User Profile avatar url =>${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl = url.toString()}');
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    String uid = Provider.of<Authentication>(context, listen: false).getUserUid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((doc) {
      print("Fetching user data");
      initUserName = doc.data()['username'];
      initUserEmail = doc.data()['useremail'];
      initUserImage = doc.data()['userimage'];
      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  Future submitChatroomData(String chatroomName, dynamic chatroomData) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomName)
        .set(chatroomData);
  }

  Future deleteUserData(String userUid, dynamic collection) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(userUid)
        .delete();
  }

  Future updateCaption(
      {@required String postId,
        @required dynamic data,
        @required String userUid}) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(data)
        .whenComplete(() {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .collection('posts')
          .doc(postId)
          .update(data);
    });
  }


  Future addAward(String postId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('awards')
        .add(data);
  }

  Future followUser(
      {@required String followingUid,
        @required String followingDocId,
        @required dynamic followingData,
        @required String followerUid,
        @required String followerDocId,
        @required dynamic followerData}) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(followingUid)
        .collection('followers')
        .doc(followingDocId)
        .set(followingData)
        .whenComplete(() async {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(followerUid)
          .collection('following')
          .doc(followerDocId)
          .set(followerData);
    });

  }
}
