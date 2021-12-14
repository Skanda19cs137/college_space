import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/uploadpost/UploadPost.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedHelpers with ChangeNotifier {
  ConstantColors constantColors = ConstantColors();

Widget feedAppBar(BuildContext context){
  return AppBar(
    backgroundColor: constantColors.darkColor.withOpacity(0.6),
    centerTitle: true,
    actions: [
      IconButton( icon: Icon(Icons.add_box,color: constantColors.greenColor,),
        onPressed: (){
        Provider.of<UploadPost>(context,listen: false).selectPostImageType(context);
        })
    ],
    title:  RichText(
      text: TextSpan(
          text: 'College Space',
          style: TextStyle(
              fontFamily: 'Poppins',
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 30.0),
          children: <TextSpan>[
            TextSpan(
                text: 'Feed',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: constantColors.blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 34.0))
          ]),
    ),
  );
}
Widget feedBody(BuildContext context){
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: constantColors.darkColor,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0),topRight: Radius.circular(18.0))
        ),
      ),
    ),
  );
}

}