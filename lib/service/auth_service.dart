import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/helper/helper_function.dart';
import 'package:flutter_chat/service/database_service.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login


//register
Future registerWithEmailAndPassword(
    String fullName,String email,String password) async {
  try{
  User user =(await firebaseAuth.createUserWithEmailAndPassword(
      email: email, password: password))
      .user!;
  if(user != null){
    await DatabaseService(uid: user.uid).savingUserData(fullName, email);
    return true;
   }
  }on FirebaseAuthException catch(e){
  print(e);
  return e;
  }
}
//LogIn
  Future loginWithEmailAndPassword(String email, String password) async{
  try{
    User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;
    if(user != null){
    return true;
    }

  }on FirebaseAuthException catch(e){
    return e;
  }
  }

//Logout
Future signOut() async{
  try{
    await HelperFunctions.storeUserName("");
    await HelperFunctions.storeEmail("");
    await HelperFunctions.storeUserLoginStatus(false);
    await firebaseAuth.signOut();
  }catch(e){
    return e;
  }
}
}