import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/helper/helper_function.dart';
import 'package:flutter_chat/pages/home_page.dart';
import 'package:flutter_chat/service/auth_service.dart';
import '../widgets/widgets.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formaKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,) ,):
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80,horizontal:
          20),
          child:Form(
            key: formaKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: [
                const Center(
                  child:Text("Flutter Chat",
                    style:
                    TextStyle(fontSize: 38,fontWeight: FontWeight.w900 ),),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Center(
                  child:Text("Register now to see what they are talking! ",
                    style:
                    TextStyle(fontSize: 18,fontWeight: FontWeight.w400 ),),
                ),
                const SizedBox(
                  height: 12,
                ),
                Image.asset(
                  "assets/images/login.jpg",
                  height: 200,
                ),
                const SizedBox(
                  height: 12,
                ),

                TextFormField(
                  onChanged: (val){
                    setState(() {
                      fullName = val;
                    });
                  },
                  validator: (val){
                    if(val!.length<4){
                      return "please enter your fullName";
                    }

                  },
                  decoration:  InputDecoration(
                      enabledBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                      labelText: "Nome",
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Por favor , insira seu Nome."
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                TextFormField(
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val){
                    return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val!)
                        ? null
                        :"Please enter a valid email";

                  },
                  decoration:  InputDecoration(
                      enabledBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      hintText: "Por favor , insira seu email."
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                TextFormField(
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                  validator: (val){
                    if(val!.length<6){
                      return "Password must be at least 6 characters";
                    }else{
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration:  InputDecoration(
                      enabledBorder:  const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey,width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.0),
                      ),
                      labelStyle: const TextStyle(color: Colors.grey),
                      floatingLabelStyle: TextStyle(color: Theme.of(context).primaryColor),
                      labelText: "Senha",
                      prefixIcon: const Icon(Icons.lock),
                      hintText: "Por favor , insira sua senha."
                  ),
                ),

                const SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        )
                    ),
                    onPressed: () {
                      register();
                    },
                    child: const Center(
                      child: Text("Register",
                        style: TextStyle(
                          fontSize: 18
                      ),),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text.rich(TextSpan(
                    text: "Already have an account?",
                    style: TextStyle(fontSize: 14,color: Colors.black),
                    children: [
                      TextSpan(
                          text: "LogIn now",
                          style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).primaryColor,
                              decoration:TextDecoration.underline ),
                          recognizer:TapGestureRecognizer()..onTap=(){
                            //Move to register
                            Navigator.pop(context);
                          }
                      )
                    ]
                ))



              ],
            ),
          ),
        ),
      ),
    );
  }
  register() async{
    if(formaKey.currentState!.validate()){
      setState(() {
        _isLoading = true;
      });
      await authService.registerWithEmailAndPassword(fullName, email, password).then((value) async{
        if(value == true){
          await HelperFunctions.storeUserLoginStatus(true);
          await HelperFunctions.storeEmail(email);
          await HelperFunctions.storeUserName(fullName);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));
        }else{
          showSnackbar(context,Colors.red,value);
          setState(() {
            _isLoading = false;
          });
        }
      });
      
    }
  }
}
