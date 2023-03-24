import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import '../const/colors.dart';
import '../utils/helper.dart';
import '../widgets/customTextInput.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Mapscreen.dart';


class AddDonation extends StatelessWidget {
  TextEditingController productController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
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
                  Text(
                    "",
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        getUserCurrentLocation().then((value) async {
                          print(value.latitude.toString() +" "+value.longitude.toString());
                          lat = value.latitude.toString();
                          long = value.longitude.toString();
                          Fluttertoast.showToast(
                              msg: "Your Latitude :"+lat+" Longitude :"+long,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor:  AppColor.orange,
                              textColor: Colors.black
                          );
                        });
                        // Navigator.push(context,MaterialPageRoute(builder: (context) =>MapScreen()));
                      },
                      child: Text("Get Location"),
                    ),
                  ),
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
                        if(lat==null&&long==null){
                          HapticFeedback.heavyImpact();
                          Fluttertoast.showToast(
                              msg: "Press Get Location to get location",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor:  AppColor.orange,
                              textColor: Colors.black
                          );
                        }
                        if(productController.text!="" && qtyController.text!="" && descController.text!=""&& lat!=null&&long!=null){
                          try {
                            var status = FirebaseFirestore.instance
                                .collection('Userdata')
                                .add({'product': productController.text,
                              'Quantity': qtyController.text,
                              'Description': descController.text,
                              'Latitude': lat,
                              'Longitude':long
                            });
                            if(status!=Null){
                              Fluttertoast.showToast(
                                  msg: "Donation Added to Database",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor:  AppColor.orange,
                                  textColor: Colors.black
                              );
                            }

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
                        else{
                          HapticFeedback.heavyImpact();
                          Fluttertoast.showToast(
                              msg: "All Fields are Mandatory",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor:  Colors.red,
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
}
