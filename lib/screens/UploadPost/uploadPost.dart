import 'dart:html';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class UploadPost with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();
  TextEditingController captionController = TextEditingController();




  //  late File uploadPostImage ;
  // File get getUploadPostImage => uploadPostImage;
  // late String uploadPostImageUrl;
  // String get getUploadPostImageUrl => uploadPostImageUrl;
  // final picker = ImagePicker();
  //UploadTask imageUploadTask;
//   Future pickUploadPostImage(BuildContext context, ImageSource source) async{
// final uploadPostImageVal = await picker.getImage(source: source);
// uploadPostImageVal == null
//     ? print('Select image')
//     : userAvatar = File(uploadPostImageVal.path);
// print(uploadPostImageVal.path);
//  uploadPostImage != null
//  ? showPostImage(context)
//  : print('Image upload error');
//  notifyListeners()
//   }
  selectPostImageType(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.39,
            width: MediaQuery
                .of(context)
                .size
                .width,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12)),
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
                        child: Text('Gallery',
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                        onPressed: () {
                          // pickUploadPostImage(context,ImageSource.gallery);
                        }),
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text('Camera',
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0)),
                        onPressed: () {
                          // pickUploadPostImage(context,ImageSource.camera);
                        })
                  ],
                )
              ],
            ),
          );
        });
  }
// Future uploadPostImageToFirebase() async{
//     Reference imageReference = FirebaseStorage.instance.ref().child(
//       'posts/${uploadPostImage.path}/${TimeofDay.now()}'
//     );
//     imagePostUploadTask = imageReference.putFile(uploadPostImage);
//     await imagePostUploadTask.whenComplete((){
//uploadPostImageUrl=imageUrl;
// print(uploadPostImageUrl);
  //notifyListeners();
// }
//   }
  showPostImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: BorderRadius.circular(12)),
            child: Column(children: [
              Padding( //this is for divider
                padding: const EdgeInsets.symmetric(horizontal: 150.0),
                child: Divider(
                  thickness: 4.0,
                  color: constantColors.whiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                child: Container(
                  height: 200.0,
                  width: 400.0,
                  child: Image.asset('images/login.png', package: 'assets',
                      fit: BoxFit.contain),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text('Reselect',
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: constantColors.whiteColor)),
                        onPressed: () {
                          selectPostImageType(context);
                        }),
                    MaterialButton(
                        color: constantColors.blueColor,
                        child: Text('Confirm Image',
                            style: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: constantColors.whiteColor)),
                        onPressed: () {
                          // uploadPostImageFirebase().whenComplete;() {
                          //     print('Image uploaded!');};
                          // }
                          editPostSheet(context);
                        })
                  ],
                ),
              ),
            ]),
          );
        });
  }

  editPostSheet(BuildContext context){
    return showModalBottomSheet(context: context,builder: (context){
      return Container(
        child:Column(
          children:[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 150.0),
              child: Divider(
                thickness: 4.0,
                color: constantColors.whiteColor,
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    child : Column(
                      children:[
                        IconButton(onPressed: (){}, icon: Icon(Icons.image_aspect_ratio,color: constantColors.greenColor )),
                        IconButton(icon: Icon(Icons.fit_screen,color:constantColors.yellowColor,),onPressed: (){},)
                      ],
                    ),
                  ),
                  Container(
                    height: 200.0,
                    width: 300.0,
                    //   child: Image.file(uploadPostImage,fit: BoxFit.contain,),
                  ),
                ],
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset('asset/icons/sunflower.png')
                  ),
                  Container(
                      height: 110.0,
                      width: 5.0,
                      color:constantColors.blueColor
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                        height: 120.0,
                        width: 330.0,
                        child:TextField(
                          maxLines: 5,
                          textCapitalization: TextCapitalization.words ,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          controller: captionController ,
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                          ),
                          decoration: InputDecoration(
                            hintText: 'Add Caption... ',
                            hintStyle: TextStyle(
                                color: constantColors.whiteColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
            MaterialButton(
              child: Text(
                'Share',
                style: TextStyle(
                    color: constantColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),

              onPressed: () async{
                Provider.of<FirebaseOperations>(context,listen:false).
                uploadPostData(captionController.text,{
                  'caption':captionController.text,
                  'username':Provider.of<FirebaseOperations>(context,listen:false).getInitUserName,
                  'userImage':Provider.of<FirebaseOperations>(context,listen:false).getInitUserImage,
                  'useruid':Provider.of<Authentication>(context,listen:false).getUserUid,
                  'time': Timestamp.now(),
                  'useremail':Provider.of<FirebaseOperations>(context,listen:false).getInitUserEmail,
                }).whenComplete((){
                  Navigator.pop(context);
                }
                );
              },
            ),
            FloatingActionButton(onPressed: () {  },
              child: Icon(FontAwesomeIcons.check, color: constantColors.whiteColor,),
            )
          ],
        ),

        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: constantColors.blueGreyColor,
            borderRadius: BorderRadius.circular(12.0)
        ),
      );
    });
  }
}
