
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Chatroom/ChatroomHelper.dart';
import 'package:college_space/screens/Profile/ProfileHelpers.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Chatroom extends StatefulWidget {
  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  final ConstantColors constantColors =ConstantColors();
  void initstate(){
    Provider.of<FirebaseOperations>(context,listen: false).initUserData(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: constantColors.blueGreyColor,
        child: Icon(FontAwesomeIcons.plus, color: constantColors.greenColor,),
        onPressed: (){
          Provider.of<ChatroomHelper>(context,listen: false).showCreateChatroomSheet(context);
        },
      ),
      appBar: AppBar(
        backgroundColor: constantColors.darkColor.withOpacity(0.6),
        centerTitle: true,
        actions: [
          IconButton( icon: Icon(EvaIcons.moreVertical,color: constantColors.whiteColor),
              onPressed: (){})
        ],
        leading:IconButton( icon: Icon(FontAwesomeIcons.plus,color: constantColors.greenColor),
            onPressed: (){
              Provider.of<ChatroomHelper>(context,listen: false).showCreateChatroomSheet(context);
            }) ,
        title:RichText(
          text: TextSpan(
              text: 'My ',
              style: TextStyle(
                  color: constantColors.whiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Chat',
                  style: TextStyle(
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0
                  ),
                )
              ]
          ),
        ) ,
      ) ,
      body: Container(
        color: constantColors.darkColor,
        height: MediaQuery.of(context).size.height ,
        width: MediaQuery.of(context).size.width,
        child: Provider.of<ChatroomHelper>(context,listen: false).showChatrooms(context),
      ),
    );
  }
}
