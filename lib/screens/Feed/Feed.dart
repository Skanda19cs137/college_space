import 'package:college_space/screens/Feed/Feed_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feed extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
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
