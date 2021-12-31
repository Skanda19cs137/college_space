import 'dart:io';

import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/LandingPage/landingServices.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class LandingUtils with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  final picker = ImagePicker();
  File userAvatar;
  File get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getUserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar = await picker.pickImage(source: source);
    pickedUserAvatar == null
        ? print('Select image')
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null
        ? Provider.of<LandingService>(context, listen: false)
        .showUserAvatar(context)
        : print('Image Upload Error');
    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.gallery)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        }),
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        })
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12.0)),
          );
        });
  }
}
