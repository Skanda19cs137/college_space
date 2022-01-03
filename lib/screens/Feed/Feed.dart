import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Feed/Feed_helpers.dart';
import 'package:college_space/screens/Profile/ProfileHelpers.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  ConstantColors constantColors = ConstantColors();
  void initstate(){
    Provider.of<FirebaseOperations>(context,listen: false).initUserData(context);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.blueGreyColor,
      drawer: Drawer(),
      appBar: PreferredSize(
        child: Provider.of<FeedHelpers>(context, listen: false)
            .feedAppBar(context),
        preferredSize: const Size.fromHeight(100),
      )
      ,
      body: Provider.of<FeedHelpers>(context,listen: false)
          .feedBody(context),
    );
  }
}