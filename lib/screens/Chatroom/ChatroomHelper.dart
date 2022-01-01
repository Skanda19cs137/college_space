import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Profile/ProfileHelpers.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatroomHelper with ChangeNotifier {
  String chatroomAvatarUrl, chatroomID;
  String get getChatroomAvatarUrl => chatroomAvatarUrl;
  String get getChatroomID => chatroomID;
  ConstantColors constantColors = ConstantColors();
  final TextEditingController chatroomNameController = TextEditingController();

  showCreateChatroomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      color: constantColors.whiteColor,
                      thickness: 4.0,
                    ),
                  ),
                  Text('Select Chatroom Avatar',
                      style: TextStyle(
                          color: constantColors.greenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0)),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chatroomIcons')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return new ListView(
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data.docs
                                .map((DocumentSnapshot documentSnapshot) {
                              return GestureDetector(
                                onTap: (){
                                  chatroomAvatarUrl=((documentSnapshot.data() as dynamic)['image']);
                                  notifyListeners();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: chatroomAvatarUrl == ((documentSnapshot.data() as dynamic)['image']) ? constantColors.blueColor : constantColors.transperant)
                                    ),
                                    height: 10.0,
                                    width: 40.0,
                                    child: Image.network((documentSnapshot.data() as dynamic)['image']),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: TextField(
                          textCapitalization: TextCapitalization.words,
                          controller: chatroomNameController,
                          style: TextStyle(
                              color: constantColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter Chatroom ID',
                            hintStyle: TextStyle(
                                color: constantColors.whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                          backgroundColor: constantColors.blueGreyColor,
                          child: Icon(FontAwesomeIcons.plus, color: constantColors.yellowColor,),
                          onPressed: () async {
                            Provider.of<FirebaseOperations>(context,listen: false).submitChatroomData (
                                chatroomNameController.text,
                                {
                                  'roomavatar':getChatroomAvatarUrl,
                                  'time':Timestamp.now(),
                                  'roomname':chatroomNameController.text,
                                  'username':Provider.of<FirebaseOperations>(context, listen: false).getInitUserName,
                                  'userimage':Provider.of<FirebaseOperations>(context, listen: false).getInitUserImage,
                                  'useremail':Provider.of<FirebaseOperations>(context, listen: false).getInitUserEmail,
                                  'useruid':Provider.of<Authentication>(context,listen: false).getUserUid
                                });
                          }
                      )
                    ],
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: constantColors.darkColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0))),
            ),
          );
        });
  }

  showChatrooms(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection('chatrooms').snapshots() ,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: SizedBox(
                height: 200.0,
                width: 200.0,
                child: Lottie.asset('assets/animations/loading.json'),
              ),
            );
          }
          else{
            return new ListView(
                children: snapshot.data.docs.map( (DocumentSnapshot documentSnapshot){
                  return ListTile(
                    title: Text((documentSnapshot.data() as dynamic)['roomname'],
                        style:TextStyle(
                            color: constantColors.whiteColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                        )),
                    trailing:Text('2 hours ago',
                        style:TextStyle(
                            color:  constantColors.whiteColor,
                            fontSize: 10.0
                        )) ,
                    subtitle:Text('Last message',
                        style:TextStyle(
                            color: constantColors.greenColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold
                        )) ,
                    leading: CircleAvatar(
                      backgroundColor: constantColors.transperant,
                      backgroundImage: NetworkImage(
                          (documentSnapshot.data() as dynamic)['roomavatar']
                      ),
                    ),
                  );
                }).toList()
            );
          }
        }
    );
  }

}

