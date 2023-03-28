import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import '../const/colors.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'Mapscreen.dart';
import 'home.dart';
import 'package:avatar_glow/avatar_glow.dart';


class AddDonation extends StatelessWidget {
  TextEditingController productController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController phController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){
    }).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR"+error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
            statusBarColor: AppColor.orange
          //color set to purple or set your own color
        )
    );
    var lat,long;
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
                    "Add Donation",
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
                    "Add your donation Details",
                    style: TextStyle(
                        color: AppColor.placeholder,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                  Text(
                    "",
                  ),
                  TextField(

                    controller: productController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: AppColor.primary), //<-- SEE HERE
                        ),
                        filled: true,
                        fillColor: Colors.black12,
                        labelText: 'Enter Item Name ',
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
                    controller: qtyController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: AppColor.primary), //<-- SEE HERE
                        ),
                        labelText: 'Quantity',
                        labelStyle: TextStyle(
                          color: AppColor.placeholder,
                        )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(color: AppColor.placeholder),
                  ),
                  Text(
                    "",
                  ),
                  TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: AppColor.primary), //<-- SEE HERE
                        ),
                        labelText: 'Enter Item Description ',
                        labelStyle: TextStyle(
                          color: AppColor.placeholder,
                        )
                    ),
                    style: TextStyle(color: AppColor.placeholder),
                  ),
                  Text(
                    "",
                  ),
                  TextField(
                    controller: phController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: AppColor.primary), //<-- SEE HERE
                        ),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: AppColor.placeholder,
                        )
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    style: TextStyle(color: AppColor.placeholder),
                  ),
                  Text(
                    "",
                  ),
                  Text(
                    "",
                  ),
                  // SizedBox(
                  //   height: 50,
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       _bac(context);
                  //       getUserCurrentLocation().then((value) async {
                  //         lat = value.latitude.toString();
                  //         long = value.longitude.toString();
                  //         if(lat!=null && long!=null){
                  //           var status = FirebaseFirestore.instance
                  //               .collection('Userdata')
                  //               .add({'product': p,
                  //             'Quantity': q,
                  //             'Description': d,
                  //             'Latitude': lat,
                  //             'Longitude':long
                  //           });
                  //           if(status!=Null){
                  //             _back(context);
                  //             /*Fluttertoast.showToast(
                  //                 msg: "Donation Added to Database",
                  //                 toastLength: Toast.LENGTH_SHORT,
                  //                 gravity: ToastGravity.BOTTOM,
                  //                 backgroundColor:  AppColor.orange,
                  //                 textColor: Colors.black
                  //             );*/
                  //           }}
                  //         Fluttertoast.showToast(
                  //             msg: "Your Latitude :"+lat+" Longitude :"+long,
                  //             toastLength: Toast.LENGTH_SHORT,
                  //             gravity: ToastGravity.BOTTOM,
                  //             backgroundColor:  AppColor.orange,
                  //             textColor: Colors.black
                  //         );
                  //       });
                  //       // Navigator.push(context,MaterialPageRoute(builder: (context) =>MapScreen()));
                  //     },
                  //     child: Text("Get Location"),
                  //   ),
                  // ),
                  Text(
                    "",
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>MapScreen()));
                      },
                      child: Text("View On Map"),
                    ),
                  ),
                  Text(
                    "",
                  ),
                  Text(
                    "",
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        // print(emailController.text);
                        // print(passwordController.text);

                        if(productController.text!="" && qtyController.text!="" && descController.text!=""&& phController.text.length==10){
                          try {
                                var p=productController.text;
                                var q=qtyController.text;
                                var d=descController.text;
                                var ph = phController.text;
                                _bac(context);
                                getUserCurrentLocation().then((value) async {
                                //print(value.latitude.toString() +" "+value.longitude.toString());
                                lat = value.latitude.toString();
                                long = value.longitude.toString();
                                if(lat!=null && long!=null){
                                var status = FirebaseFirestore.instance
                                    .collection('Userdata').doc(p+ph)
                                    .set({'product': p,
                                'Quantity': q,
                                'Description': d,
                                  'Phone_number':ph,
                                'Latitude': lat,
                                'Longitude':long
                                });
                                if(status!=Null){
                                // _back(context);
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>SecondPage()));
                                /*Fluttertoast.showToast(
                                                              msg: "Donation Added to Database",
                                                              toastLength: Toast.LENGTH_SHORT,
                                                              gravity: ToastGravity.BOTTOM,
                                                              backgroundColor:  AppColor.orange,
                                                              textColor: Colors.black
                                                          );*/
                                }}

                                });
                          } catch (e) {
                            HapticFeedback.heavyImpact();
                            print(e);
                            Fluttertoast.showToast(
                                msg: e.toString(),
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor:  AppColor.orange,
                                textColor: Colors.black
                            );
                          }
                        }
                        else if(phController.text.length!=10){
                          HapticFeedback.heavyImpact();
                          Fluttertoast.showToast(
                              msg: "Invalid Phone Number",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor:  AppColor.orange,
                              textColor: Colors.black
                          );
                        }
                        else if(lat==null&&long==null){
                          HapticFeedback.heavyImpact();
                          Fluttertoast.showToast(
                              msg: "Press Get Location to get location",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor:  AppColor.orange,
                              textColor: Colors.black
                          );
                        }
                        else{
                          HapticFeedback.heavyImpact();
                          Fluttertoast.showToast(
                              msg: "All Fields are Mandatory",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor:  Colors.orange,
                              textColor: Colors.black
                          );
                        }

                      },
                      child: Text("Donate"),
                    ),
                  ),
                  Text(""),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(context,MaterialPageRoute(builder: (context) =>LoginScreen()));
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text("Already have an Account? "),
                  //       Text(
                  //         "Login",
                  //         style: TextStyle(
                  //           color: AppColor.orange,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Spacer()
                ],
              ),
            ),
          ),
        ));
  }
  /*Future _back(BuildContext context) async{
    bool s = await showDialog(context: context, builder: (BuildContext context){
      return Container(
        color:Colors.black.withOpacity(.75) ,

        child: AlertDialog(title:const Text(""),content: const Text("       Donation Added",style: TextStyle(
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
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              },child:const Text("Continue to Home"),),
          ],),
      );
    });
  }*/
  Future _bac(BuildContext context) async{
    bool s = await showDialog(context: context, builder: (BuildContext context){
      return Container(
        color:Colors.black.withOpacity(.75) ,

        child: Center(
          child: AlertDialog(
            backgroundColor: Colors.black,
            content:
            Center(
              child: AvatarGlow(
                glowColor: Colors.white,
                endRadius: 120,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                curve: Curves.easeOutQuad,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: AppColor.orange, borderRadius: BorderRadius.circular(99)),
                  child: Icon(
                    Icons.location_on_outlined,
                    color: Colors.black,
                    size: 40,
                  ),
                    // child: Text("       Fetching Location.....",style: TextStyle(
                    //     color: AppColor.primary,
                    //     fontWeight: FontWeight.normal,
                    //     fontSize: 20
                    // ))
                ),
              ),
            ),

          ),
        ),
      );
    });
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
      });
    });
    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    Timer(Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    Timer(Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(Duration(milliseconds: 3400), () {
      setState(() {
        _d = true;
      });
    });
    Timer(Duration(milliseconds: 3850), () {
      setState(() {
        Navigator.of(context).pushReplacement(
          ThisIsFadeRoute(
            route: MyCustomUI(),
          ),
        );
      });
    });
  }

  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                  ? _h / 2
                  : 20,
              width: 20,
              // color: Colors.deepPurpleAccent,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                      ? 2
                      : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                  ? 80
                  : 20,
              width: _d
                  ? _w
                  : _c
                  ? 200
                  : 20,
              decoration: BoxDecoration(
                  color: _b ? AppColor.orange : Colors.transparent,
                  // shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius:
                  _d ? BorderRadius.only() : BorderRadius.circular(30)),
              child: Center(
                child: _e
                    ? AnimatedTextKit(
                  totalRepeatCount: 1,
                  animatedTexts: [
                    FadeAnimatedText(
                      'Donation Added',
                      duration: Duration(milliseconds: 1700),
                      textStyle: TextStyle(
                        fontSize: 20,
                        color: AppColor.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                )
                    : SizedBox(),
              ),
            ),
          ],
        ),
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