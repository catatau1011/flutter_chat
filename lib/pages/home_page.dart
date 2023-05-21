import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/helper_function.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/profile_page.dart';
import 'package:flutter_chat/service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  String userName = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    getuserData();
  }
  void getuserData() async {
    await  HelperFunctions.getUserEmail().then((value){
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
    return  Scaffold(
      appBar: AppBar(
        actions: [
           InkWell(
            onTap: (){

            },
            child: Icon(Icons.search),
         )
       ],
       centerTitle: true,
       elevation: 0,
       backgroundColor: Theme.of(context).primaryColor,
       title: const Text("Groups",style: TextStyle(
         color: Colors.white,
         fontWeight:  FontWeight.bold,
         fontSize: 27
       ),),

     ),
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
              onTap: (){},
              selectedColor: Theme.of(context).primaryColor,
              selected: true,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: Icon(Icons.group),
              title: Text(
                  "Groups",
              style: TextStyle(color: Colors.black),),
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const ProfilePage()));
              },
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
     body: groupList(),
    );
  }

  groupList()async {

  }

}
