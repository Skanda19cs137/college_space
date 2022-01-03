import 'package:college_space/constants/Constantcolors.dart';
import 'package:college_space/screens/Chatroom/ChatroomHelper.dart';
import 'package:college_space/screens/Feed/Feed_helpers.dart';
import 'package:college_space/screens/Homepage/HomePageHelpers.dart';
import 'package:college_space/screens/LandingPage/LandingUtil.dart';
import 'package:college_space/screens/LandingPage/landingHelpers.dart';
import 'package:college_space/screens/LandingPage/landingServices.dart';
import 'package:college_space/screens/Messaging/GroupMessageHelper.dart';
import 'package:college_space/screens/Profile/ProfileHelpers.dart';
import 'package:college_space/screens/Splashscreen/splashScreen.dart';
import 'package:college_space/screens/UploadPost/uploadPost.dart';
import 'package:college_space/services/Authentication.dart';
import 'package:college_space/services/FirebaseOperations.dart';
import 'package:college_space/utils/PostOptions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initstate(){
    Provider.of<FirebaseOperations>(context,listen: false).initUserData(context);
    super.initState();
  }
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
          home: Splashscreen(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Poppins',
              canvasColor: Colors.transparent, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constantColors.blueColor)),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => PostFunctions()),
          ChangeNotifierProvider(create: (_) => HomepageHelpers()),
          ChangeNotifierProvider(create: (_) => LandingUtils()),
          ChangeNotifierProvider(create: (_) => FirebaseOperations()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => FeedHelpers()),
          ChangeNotifierProvider(create: (_) => ProfileHelpers()),
          ChangeNotifierProvider(create: (_) => UploadPost()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => LandingHelpers()),
          ChangeNotifierProvider(create: (_) => LandingService()),
          ChangeNotifierProvider(create: (_) => ChatroomHelper()),
          ChangeNotifierProvider(create: (_) => GroupMessageHelper())
        ]);
  }
}
