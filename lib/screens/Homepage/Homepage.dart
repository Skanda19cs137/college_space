import 'package:college_space/constants/Constantcolors.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.greyColor,
    );
  }
}
