import 'package:college_space/screens/LandingPage/landingServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Authentication with ChangeNotifier
{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  String userUid;
  String get getUserUid {
    return userUid;
  }
  Future logIntoAccount(BuildContext context,String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      userUid= FirebaseAuth.instance.currentUser.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Provider.of<LandingService>(context, listen: false).warningText(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    print(userUid);
    notifyListeners();
  }

  Future createAccount(String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      userUid= FirebaseAuth.instance.currentUser.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    print(userUid);
    notifyListeners();
  }

  Future logOutViaEmail(){
    return firebaseAuth.signOut();
  }


  Future signInWithGoogle() async{

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential authCredential =  GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
    final UserCredential userCredential = await firebaseAuth.signInWithCredential(authCredential);
    final User user = userCredential.user;
    assert(user.uid != null);

    userUid = user.uid;
    print("Google user UID => $userUid");
    notifyListeners();
  }

  Future signOutWithGoogle() async{
    return googleSignIn.signOut();
  }
}