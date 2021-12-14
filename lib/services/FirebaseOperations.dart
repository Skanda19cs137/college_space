import 'package:cloud_firestore/cloud_firestore.dart';

Future uploadPostData(String postId,dynamic data)async{
  return FirebaseFirestore.instance.collection('post').doc(
    postId
  ).set(data);
}