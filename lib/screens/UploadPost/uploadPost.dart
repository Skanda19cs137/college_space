import 'package:college_space/screens/LandingPage/landingServices.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:js/js.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nanoid/async.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


class UploadPost with ChangeNotifier {
  File uploastPostImage;
  File get getUploadPostImage => uploastPostImage;
  String uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl;
  final picker = ImagePicker();
  UploadTask imagePostUploadTask;
  TextEditingController captionController = TextEditingController();
  final ConstantColors constantColors= ConstantColors();
  Future pickUploadPostImage(BuildContext context, ImageSource source) async {
    final uploadPostImageVal =
    await picker.getImage(source: source, imageQuality: 40);
    uploadPostImageVal == null
        ? print('Select Image')
        : uploastPostImage = File(uploadPostImageVal.path);

    uploastPostImage != null ? showPostImage(context) : print('Error');
    notifyListeners();
  }

  Future uploadPostImageToFirebase(BuildContext context) async {
    Reference imgReference = FirebaseStorage.instance.ref().child(
        'posts/${Provider.of<Authentication>(context, listen: false).getUserUid}/${TimeOfDay.now()}');

    imagePostUploadTask = imgReference.putFile(uploastPostImage);
    await imagePostUploadTask.whenComplete(() {
      print('Image Uploaded To DB');
    });

    imgReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      print(uploadPostImageUrl);
    });
    notifyListeners();
  }

  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      color: constantColors.blueColor,
                      onPressed: () {
                        pickUploadPostImage(context, ImageSource.gallery);
                      },
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    MaterialButton(
                      color: constantColors.redColor,
                      onPressed: () {
                        pickUploadPostImage(context, ImageSource.camera);
                      },
                      child: Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: constantColors.whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.35,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.darkColor,
              borderRadius: BorderRadius.circular(12.0),
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
                Padding(
                  padding:
                  const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Container(
                      height: 200,
                      width: 400,
                      child: uploastPostImage != null
                          ? Image.file(
                        uploastPostImage,
                        fit: BoxFit.contain,
                      )
                          : AssetImage('assets/images/empty.png')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          selectPostImageType(context);
                        },
                        child: Text(
                          'Reselect Image',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: constantColors.whiteColor),
                        ),
                      ),
                      MaterialButton(
                        color: constantColors.blueColor,
                        onPressed: () {
                          uploadPostImageToFirebase(context).whenComplete(() {
                            editPostSheet(context);
                            print('Image Uploaded');
                          });
                        },
                        child: Text(
                          'Confirm Image',
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  editPostSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(12.0),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 200.0,
                          width: 300.0,
                          child: Image.file(
                            uploastPostImage,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          EvaIcons.messageCircle,
                          color: constantColors.whiteColor,
                        ),
                      ),
                      Container(
                        height: 110.0,
                        width: 5.0,
                        color: constantColors.blueColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 120.0,
                          width: 330.0,
                          child: TextField(
                            maxLines: 5,
                            textCapitalization: TextCapitalization.words,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(100)
                            ],
                            maxLength: 100,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            controller: captionController,
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                            decoration: InputDecoration(
                              hintText: 'Caption Here',
                              hintStyle: TextStyle(
                                  color: constantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  color: constantColors.blueColor,
                  onPressed: () async {
                    String randomID = Uuid().v4();
                    if (captionController.text.isNotEmpty) {
                      print('Collection Created : Data Uploaded');
                      Provider.of<FirebaseOperations>(context, listen: false)
                          .uploadPostData(randomID, {
                        'postid': randomID,
                        'postimage': getUploadPostImageUrl,
                        'caption': captionController.text,
                        'username': Provider.of<FirebaseOperations>(context,
                            listen: false)
                            .getInitUserName,
                        'userimage': Provider.of<FirebaseOperations>(context,
                            listen: false)
                            .getInitUserImage,
                        'useruid':
                        Provider.of<Authentication>(context, listen: false)
                            .getUserUid,
                        'time': Timestamp.now(),
                        'useremail': Provider.of<FirebaseOperations>(context,
                            listen: false)
                            .getInitUserEmail,
                      }).whenComplete(() async {
                        // Add Data User To User Profile
                        return FirebaseFirestore.instance
                            .collection('users')
                            .doc(Provider.of<Authentication>(context,
                            listen: false)
                            .getUserUid)
                            .collection('posts')
                            .doc(randomID)
                            .set({
                          'postid': randomID,
                          'postimage': getUploadPostImageUrl,
                          'caption': captionController.text,
                          'username': Provider.of<FirebaseOperations>(context,
                              listen: false)
                              .getInitUserName,
                          'userimage': Provider.of<FirebaseOperations>(context,
                              listen: false)
                              .getInitUserImage,
                          'useruid': Provider.of<Authentication>(context,
                              listen: false)
                              .getUserUid,
                          'time': Timestamp.now(),
                          'useremail': Provider.of<FirebaseOperations>(context,
                              listen: false)
                              .getInitUserEmail,
                        });
                      }).whenComplete(() {
                        captionController.clear();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      });
                    } else {
                      Provider.of<LandingService>(context, listen: false)
                          .warningText(context,
                          'Please Type Something In Order To Post');
                    }
                  },
                  child: Text(
                    'Share',
                    style: TextStyle(
                        color: constantColors.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                )
              ],
            ),
          );
        });
  }
}
