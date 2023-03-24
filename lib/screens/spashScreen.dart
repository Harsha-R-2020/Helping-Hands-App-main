// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
import 'package:flutter/services.dart';

import './landingScreen.dart';
import '../utils/helper.dart';
import '../const/colors.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   Timer _timer;
//
//   @override
//   void initState() {
//     _timer = Timer(Duration(milliseconds: 4000), () {
//       Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: Helper.getScreenWidth(context),
//         height: Helper.getScreenHeight(context),
//         child: Stack(
//           children: [
//             Container(
//               height: double.infinity,
//               width: double.infinity,
//               child: Image.asset(
//                 Helper.getAssetName("splashIcon.png", "virtual"),
//                 fit: BoxFit.fill,
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Image.asset(
//                 Helper.getAssetName("applogo.png", "virtual"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class MyCustomWidget extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Helping Hands',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
              ),
            ),
            OpenContainer(
              closedBuilder: (_, openContainer) {
                return Container(
                  height: 200,
                  width: 200,
                  child: Center(

                    child: Image.asset(
                      Helper.getAssetName("applogo.png", "virtual"),
                      fit: BoxFit.contain,
                      height: 200,
                      width: 200,
                    ),
                  ),
                );
              },
              openColor: Colors.white,
              closedElevation: 20,
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              transitionDuration: Duration(milliseconds: 700),
              openBuilder: (_, closeContainer) {
                return SecondClass();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondClass extends StatefulWidget {
  @override
  _SecondClassState createState() => _SecondClassState();
}

class _SecondClassState extends State<SecondClass>
    with TickerProviderStateMixin {
  AnimationController scaleController;
  Animation<double> scaleAnimation;

  double _opacity = 0;
  bool _value = true;

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addStatusListener(
          (status) {
        if (status == AnimationStatus.completed) {
          HapticFeedback.mediumImpact();
          Navigator.of(context).pushReplacement(
            ThisIsFadeRoute(
              route: LandingScreen(),
            ),
          );
          Timer(
            Duration(milliseconds: 300),
                () {
              scaleController.reset();
            },
          );
        }
      },
    );

    scaleAnimation =
        Tween<double>(begin: 0.0, end: 12).animate(scaleController);

    Timer(Duration(milliseconds: 600), () {
      setState(() {
        _opacity = 1.0;
        _value = false;
      });
    });
    Timer(Duration(milliseconds: 2000), () {
      setState(() {
        scaleController.forward();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scaleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppColor.orange
          //color set to purple or set your own color
        )
    );
    return Scaffold(

      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  'Helping Hands',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: AnimatedOpacity(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(seconds: 6),
              opacity: _opacity,
              child: AnimatedContainer(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(seconds: 2),
                height: _value ? 50 : 200,
                width: _value ? 50 : 200,

                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.orange.withOpacity(.2),
                      blurRadius: 100,
                      spreadRadius: 10,
                    ),
                  ],
                  color: AppColor.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(

                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        color: AppColor.orange, shape: BoxShape.circle,
                        image: DecorationImage(
                    image: AssetImage(Helper.getAssetName("applogo.png", "virtual")),
                    fit: BoxFit.fill,
                  ),
                    ),
                    child: AnimatedBuilder(
                      animation: scaleAnimation,
                      builder: (c, child) => Transform.scale(
                        scale: scaleAnimation.value,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.orange,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({this.page, this.route})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: route,
        ),
  );
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Go Back'),
        centerTitle: true,
        brightness: Brightness.dark,
        backgroundColor: Colors.deepPurpleAccent,
      ),
    );
  }
}