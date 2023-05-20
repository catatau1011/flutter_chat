import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/service/database_service.dart';

class AuthService{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //login


//register
Future registerWithEmailAndPassword(String fullName,String email,String password) async {
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

//Logout

}