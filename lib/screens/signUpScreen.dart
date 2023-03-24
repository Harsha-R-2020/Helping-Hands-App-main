import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/colors.dart';
import '../screens/loginScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  static const routeName = '/signUpScreen';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppColor.orange
          //color set to purple or set your own color
        )
    );
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:Colors.black87,
        body: Container(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Column(
            children: [
              Spacer(),
              Text(
                "Sign Up",
                // style: Helper.getTheme(context).headline6,
                style: TextStyle(
                    color: AppColor.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              ),
              Text(
                "",
              ),
              Text(
                "Add your details to sign up",
                style: TextStyle(
                    color: AppColor.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),
              ),
              Text(
                "",
              ),
              TextField(

                controller: emailController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: AppColor.primary), //<-- SEE HERE
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: 'Enter your Email ',
                    labelStyle: TextStyle(
                      color: AppColor.placeholder,
                    )

                ),
                style: TextStyle(color: AppColor.placeholder),
              ),
              Text(
                "",
              ),
              // CustomTextInput(
              //   hintText: "password",
              // ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 3, color: AppColor.primary), //<-- SEE HERE
                    ),
                    filled: true,
                    fillColor: Colors.black12,
                    labelText: 'Password ',
                    labelStyle: TextStyle(
                      color: AppColor.placeholder,
                    )

                ),
                style: TextStyle(color: AppColor.placeholder),
              ),
              Text(
                "",
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    print(emailController.text);
                    print(passwordController.text);
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      final credential = await auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (credential != null) {
                        // Navigator.pushNamed(context, 'home_screen');
                        // print('Login Successfull');
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                        Fluttertoast.showToast(
                            msg: 'The account Created Successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,

                            backgroundColor:  AppColor.orange,
                            textColor: Colors.black
                        );
                      }
                    } on FirebaseAuthException catch (e) {
                      HapticFeedback.heavyImpact();
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                        Fluttertoast.showToast(
                            msg: 'The password provided is too weak.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,

                            backgroundColor:  AppColor.orange,
                            textColor: Colors.black
                        );
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                        Fluttertoast.showToast(
                            msg: 'The account already exists for that email.',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,

                            backgroundColor:  AppColor.orange,
                            textColor: Colors.black
                        );
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,

                            backgroundColor:  AppColor.orange,
                            textColor: Colors.black
                        );
                      }
                    } catch (e) {
                      print(e);
                      Fluttertoast.showToast(
                          msg: e.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,

                          backgroundColor:  AppColor.orange,
                          textColor: Colors.black
                      );
                    }
                  },
                  child: Text("Sign Up"),
                ),
              ),
              Text(""),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an Account? ",style: TextStyle(
                        color: AppColor.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 10
                    ),),
                    Text(
                      "Login",
                      style: TextStyle(
                        color: AppColor.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer()
            ],
          ),
        ),
      ),
    ));
  }
}
