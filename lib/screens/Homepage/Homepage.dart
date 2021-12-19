import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Feed/Feed.dart';
import 'package:college_space/screens/Homepage/HomePageHelpers.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: constantColors.greyColor,
        body: PageView(
          controller: homepageController,
          children: [
            Feed(),
            //profile()
          ],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(page);
          },
        ),
        bottomNavigationBar:
            Provider.of<HomepageHelpers>(context, listen: false)
                .bottomNavBar(pageIndex, homepageController));
  }

  void setState(int page) {
    pageIndex = page;
  }
}
