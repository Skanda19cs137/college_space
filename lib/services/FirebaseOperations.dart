import 'package:cloud_firestore/cloud_firestore.dart';
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
  late UploadTask imageUploadTask;

  get getInitUserName => null;

  get getInitUserEmail => null;

  get getInitUserImage => null;

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<landingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');
    imageUploadTask = imageReference.putFile(
        Provider.of<landingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask.whenComplete(() {
      print('Image Uploaded!');
    });

    imageReference.getDownloadURL().then((url) {
      Provider.of<landingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          'The User Profile avatar url =>${Provider.of<landingUtils>(context, listen: false).userAvatarUrl = url.toString()}');
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance.collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }
  Future uploadPostData(String postId,dynamic data)async{
    return FirebaseFirestore.instance.collection('post').doc(
        postId
    ).set(data);
  }

  Future submitChatroomData( String chatroomName , dynamic chatroomData) async{
    return FirebaseFirestore.instance.collection('chatrooms').doc(chatroomName).set(chatroomData);
  }
}

