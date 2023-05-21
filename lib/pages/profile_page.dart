import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/helper_function.dart';
import 'package:flutter_chat/pages/home_page.dart';

import '../service/auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  String userName = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }
  void getUserData() async {
  await HelperFunctions.getUserEmail().then((value){
    setState(() {
      email = value!;
    });
  });
  await HelperFunctions.getUserName().then((value){
    userName = value!;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        title: Text("Profile",style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 27,
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ) ,
      drawer: Drawer(
        child: ListView(
          padding:  EdgeInsets.symmetric(vertical: 50),
          children:  [
            Icon(Icons.account_circle,size: 150,color: Colors.grey,),
            SizedBox(height: 18,),
            Text(userName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),),
            SizedBox(
              height: 30,
            ),
            Divider(
              height: 2,
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomePage()));
              },
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
                "Groups",
                style: TextStyle(color: Colors.black),),
            ),
            ListTile(
              onTap: (){
              Navigator.pop(context);
              },
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: Icon(Icons.person),
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: ()async{
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you wamt to lougout?"),
                        actions: [
                          IconButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: ()async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context)=> const LoginPage()),
                                      (route) => false);
                            },
                            icon: Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),

                        ],
                      );
                    });
              },
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              leading: Icon(Icons.exit_to_app),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
       width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: [
            Icon(Icons.account_circle,size: 120,color: Theme.of(context).primaryColor,),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Text("Full Name :", style: TextStyle(fontSize: 17),),
                Text(userName, style: TextStyle(fontSize: 17),),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Text("Email :", style: TextStyle(fontSize: 17),),
                Text(email, style: TextStyle(fontSize: 17),),
              ],
            ),

          ],
        ),
      ),
    );
  }

}
