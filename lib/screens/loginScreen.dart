import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:monkey_app_demo/screens/forgetPwScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../const/colors.dart';
import '../screens/forgetPwScreen.dart';
import '../screens/signUpScreen.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import 'home.dart';
import 'FindItems.dart';


class LoginScreen extends StatelessWidget {
  static const routeName = "/loginScreen";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()=>_back(context),
    child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Colors.black87,
      body: Container(

        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Spacer(),
                Text(
                  "Login",
                  style: TextStyle(
                      color: AppColor.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                  ),
                ),
                Text("",),
                Text('Add your details to login',
                  style: TextStyle(
                      color: AppColor.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),),
                Text("",),
                // CustomTextInput(
                //   hintText: "Your email",
                //
                // ),
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
                Spacer(),
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
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      HapticFeedback.mediumImpact();
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text
                        );
                        if(credential != null){
                          print('Login Successfull $credential');
                          Fluttertoast.showToast(
                              msg: 'Login Successfull',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,

                              backgroundColor:  AppColor.orange,
                              textColor: Colors.black
                          );
                          if(emailController.text == 'hi@gmail.com') {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => FindItems()));
                          }else{
                          Navigator.push(context,MaterialPageRoute(builder: (context) => MyCustomUI()));}
                          // Navigator.of(context)
                          //     .pushReplacementNamed(HomeScreen.routeName);
                        }
                      } on FirebaseAuthException catch (e) {
                        HapticFeedback.heavyImpact();
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                          Fluttertoast.showToast(
                              msg: 'No user found for that email.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,

                              backgroundColor:  Colors.red,
                              textColor: Colors.black
                          );
                        } else if (e.code == 'invalid-email'){
                          Fluttertoast.showToast(
                              msg: 'The Email address is badly formatted.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,

                              backgroundColor:  Colors.red,
                              textColor: Colors.black
                          );
                        }
                        else if (e.code == 'unknown'){
                          Fluttertoast.showToast(
                              msg: 'All Fields are Mandatory.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,

                              backgroundColor:  Colors.red,
                              textColor: Colors.black
                          );
                        }
                        else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                          Fluttertoast.showToast(
                              msg: 'Wrong password provided for that user.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,

                              backgroundColor:  Colors.red,
                              textColor: Colors.black
                          );
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: e.toString(),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,

                              backgroundColor:  Colors.red,
                              textColor: Colors.black
                          );
                        }
                      }


                      },
                    child: Text("Login",style: TextStyle(fontSize: 25)),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>ForgetPwScreen()));
                    // Navigator.of(context)
                    //     .pushReplacementNamed(ForgetPwScreen.routeName);
                  },
                  child: Text("Forget your password?",style: TextStyle(fontSize: 15 ,color: AppColor.orange,
                    fontWeight: FontWeight.bold, )),
                ),
                Spacer(
                ),
                Text("or Login With",style: TextStyle(
                    color: AppColor.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
                Spacer(),
                // SizedBox(
                //   height: 50,
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     style: ButtonStyle(
                //       backgroundColor: MaterialStateProperty.all(
                //         Color(
                //           0xFF367FC0,
                //         ),
                //       ),
                //     ),
                //     onPressed: () {},
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Image.asset(
                //           Helper.getAssetName(
                //             "fb.png",
                //             "virtual",
                //           ),
                //         ),
                //         SizedBox(
                //           width: 30,
                //         ),
                //         Text("Login with Facebook")
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                      Colors.black,

                      ),
                      side: MaterialStateProperty.all(BorderSide(width: 2.0, color: AppColor.orange)),
                    ),

                    onPressed: () async {
                      try{
                        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

                        // Obtain the auth details from the request
                        final GoogleSignInAuthentication googleAuth = await googleUser?.authentication;

                        // Create a new credential
                        final credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken,
                        );
                        if(credential!=null){
                          Fluttertoast.showToast(
                              msg: 'Login Successfull',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,

                              backgroundColor:  AppColor.orange,
                              textColor: Colors.black
                          );
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>MyCustomUI()));
                        }

                      }catch(e){
                        print(e.toString());
                        Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,

                            backgroundColor:  AppColor.orange,
                            textColor: Colors.black
                        );
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Helper.getAssetName(
                            "google.png",
                            "virtual",
                          ),
                          height: 40,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Login with Google",style: TextStyle(fontSize: 20,color: AppColor.orange))
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.of(context)
                        .pushReplacementNamed(SignUpScreen.routeName);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?",style: TextStyle(
                  color: AppColor.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
  Future<bool> _back(BuildContext context) async{
    bool s = await showDialog(context: context, builder: (BuildContext context){
      return Container(
        color:Colors.black.withOpacity(.75) ,

        child: AlertDialog(title: const Text("Do you really want to exit ?",style: TextStyle(
            color: AppColor.primary,
            fontWeight: FontWeight.normal,
            fontSize: 20
        )),

          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.orange,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: (){
                Navigator.of(context).pop(false);
              }, child: const Text("No"),),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.orange,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: (){
                // Navigator.of(context).pop(true);
                SystemNavigator.pop();
              }, child: const Text("Yes"),),
          ],),
      );
    });
    return s ?? false;
  }
}
