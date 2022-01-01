import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Chatroom/Chatroom.dart';
import 'package:college_space/screens/Feed/Feed.dart';
import 'package:college_space/screens/Homepage/HomePageHelpers.dart';
import 'package:college_space/screens/Profile/profile.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initstate(){
    Provider.of<FirebaseOperations>(context,listen: false).initUserData(context);
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.greyColor,
        body: PageView(
          controller: homepageController,
          children: [
            Feed(),
            Chatroom(),
            Profile()
          ],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            pageIndex = page;
          },
        ),
        bottomNavigationBar:
        Provider.of<HomepageHelpers>(context, listen: false)
            .bottomNavBar(context,pageIndex, homepageController));
}

}
