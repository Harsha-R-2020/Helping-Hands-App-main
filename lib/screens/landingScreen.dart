import 'package:flutter/material.dart';
import 'package:clip_shadow/clip_shadow.dart';
import 'package:flutter/services.dart';
import 'package:monkey_app_demo/screens/introScreen.dart';
import 'package:monkey_app_demo/screens/loginScreen.dart';

import '../const/colors.dart';
import '../utils/helper.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = "/landingScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.black87,
        body: Container(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ClipShadow(
              clipper: CustomClipperAppBar(),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 15),
                  blurRadius: 10,
                ),
              ],
              child: Container(
                width: double.infinity,
                height: Helper.getScreenHeight(context) * 0.5,
                decoration: ShapeDecoration(
                  color: AppColor.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Image.asset(
                  Helper.getAssetName("login_bg.png", "virtual"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              Helper.getAssetName("applogowhite.png", "virtual"),
              fit: BoxFit.contain,
              height: 200,
              width: 200,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.4,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Text(
                    "Helping Hands",
                    textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: AppColor.orange),
                  ),
                  Flexible(
                    child: Text(
                      "The purpose of human life is to serve, and to show compassion and the will to help others.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                        // Navigator.of(context)
                        //     .pushReplacementNamed(LoginScreen.routeName);
                      },
                      child: Text("Login"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black12),
                        foregroundColor:
                            MaterialStateProperty.all(AppColor.orange),
                        shape: MaterialStateProperty.all(
                          StadiumBorder(
                            side:
                                BorderSide(color: AppColor.orange, width: 1.5),
                          ),
                        ),
                      ),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>IntroScreen()));
                        // Navigator.of(context)
                        //   .pushReplacementNamed(IntroScreen.routeName);
                        },
                      child: Text("Create an Account"),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
