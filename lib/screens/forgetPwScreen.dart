import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:monkey_app_demo/screens/loginScreen.dart';

import '../const/colors.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import './sentOTPScreen.dart';

class ForgetPwScreen extends StatelessWidget {
  static const routeName = "/loginScreen";
  TextEditingController emailController = TextEditingController();
  var _status;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppColor.orange
          //color set to purple or set your own color
        )
    );
    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenWidth(context),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Column(
              children: [
                Text(
                  "Reset Password",
                  style: Helper.getTheme(context).headline6,
                ),
                Spacer(),
                Text(
                  "Please enter your email to recieve a link to create a new password via email",
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 2),
              TextField(

                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Your Email',
                ),
              ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try{
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: emailController.text).then((value) => _status = 1);
                        if(_status==1){
                          Fluttertoast.showToast(
                              msg: 'Password Reset Link Sent To your Email',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor:  AppColor.orange,
                              textColor: Colors.black
                          );
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                        }

                      }catch(e){
                        HapticFeedback.vibrate();
                        Fluttertoast.showToast(
                            msg: e.toString(),
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,

                            backgroundColor:  AppColor.orange,
                            textColor: Colors.black
                        );
                      }

                    },
                    child: Text("Send"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
