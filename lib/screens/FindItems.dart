import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../const/colors.dart';
import '../utils/helper.dart';
import 'MapScreen1.dart';

class FindItems extends StatefulWidget {
  @override
  _FindItemsState createState() => _FindItemsState();
}
class Data {
  String text;
  String qty;
  String desc;
  String phone;
  String lat,long;
  Data({this.text, this.qty,this.desc,this.phone,this.lat,this.long});
}


class _FindItemsState extends State<FindItems>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  Animation<double> _animation2;
  List userProfileList = [];

  fetchDatabaseList() async {
    dynamic resultant = await getUsersList();
    if (resultant == null) {
      Fluttertoast.showToast(
          msg:"Unable to load data..",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor:  AppColor.orange,
          textColor: Colors.black
      );
      print("Unable to load data..");
    }
    else {
      setState(() {
        userProfileList = resultant;
      });
    }
  }

  final CollectionReference profileList = FirebaseFirestore.instance.collection(
      'Userdata');

  getUsersList() async {
    List itemList = [];
    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    }
    catch(e){
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor:  AppColor.orange,
          textColor: Colors.black
      );
      print(e.toString());
      return null;
    }
  }
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:Colors.black87,
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        brightness: Brightness.dark,
        elevation: 0,
        title: Text('Available Products'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     tooltip: 'Settings',
        //     enableFeedback: true,
        //     icon: Icon(
        //       CupertinoIcons.gear_alt_fill,
        //     ),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => RouteWhereYouGo(),
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Stack(

        children: [
          // ListView.(
          //   physics:
          //   BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          //   children: [
          //     SizedBox(height: _w / 13),
          //     cards("hello","world"),
          //     cards("sample","Apllication")
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: ListView.builder(
                  itemCount: userProfileList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                        color: AppColor.orange.withOpacity(.9),
                     child: InkWell(
                      enableFeedback: true,
                      onTap: () {

                        final data = Data(
                            text: userProfileList[index]['product'],
                            qty : userProfileList[index]['Quantity'],
                            desc: userProfileList[index]['Description'],
                            phone:userProfileList[index]['Phone_number'],
                            lat:userProfileList[index]['Latitude'],
                            long:userProfileList[index]['Longitude']
                        );

                        print(data);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RouteWhereYouGo(
                              data: data,
                            ),
                            // Pass the arguments as part of the RouteSettings. The
                            // DetailScreen reads the arguments from these settings.
                            // settings: RouteSettings(
                            //   arguments: userProfileList[index]['Phone_number'],
                            // ),
                          ),
                        );
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                          child:Container(
                            margin: EdgeInsets.fromLTRB(_w / 45, _w / 45, _w / 45, 0.5),
                            padding: EdgeInsets.all(_w / 25),
                            height: _w / 4.4,
                            width: _w,
                            alignment: Alignment.center,
                            // decoration: BoxDecoration(
                            //   // color: AppColor.orange.withOpacity(.9),
                            //   borderRadius: BorderRadius.circular(20),
                            // ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue.withOpacity(.5),
                                  radius: _w / 15,
                                  child: Icon(
                                    Icons.card_giftcard_rounded,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: _w / 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                    userProfileList[index]['product']!=null ? userProfileList[index]['product']:'',
                                        textScaleFactor: 1.6,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(.7),
                                        ),
                                      ),
                                      Text(
                                        userProfileList[index]['Description'] !=null ? userProfileList[index]['Description']:'',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black.withOpacity(.8),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Icon(Icons.navigate_next_outlined)
                              ],
                            ),
                          ),
                      // SizedBox(
                      //   title: Text(userProfileList[index]['product']!=null ? userProfileList[index]['product']:'' ,
                      //     textScaleFactor: 1.6,
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w600,
                      //       color: Colors.black.withOpacity(.7),
                      //     ),),
                      //   subtitle: Text(userProfileList[index]['Description'] !=null ? userProfileList[index]['Description']:'',
                      //     style: TextStyle(
                      //       fontWeight: FontWeight.w400,
                      //       color: Colors.black.withOpacity(.8),
                      //     ),),
                      // ),
                     ),
                    );

                  }
              ),
            ),
          ),
          // top me rahna
          CustomPaint(
            painter: MyPainter(),
            child: Container(height: 0),
          ),
        ],
      ),
      // body: Container(
      //     child: ListView.builder(
      //         itemCount: userProfileList.length,
      //         itemBuilder: (context, index) {
      //           return Card(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(15.0),
      //             ),
      //             color: Colors.grey,
      //             elevation: 10,
      //             child:ListTile(
      //               title: Text(userProfileList[index]['product']!=null ? userProfileList[index]['product']:'' ),
      //               subtitle: Text(userProfileList[index]['Description'] !=null ? userProfileList[index]['Description']:'' ),
      //             ),
      //
      //           );
      //         }
      //     )
      // ),
    );
  }

  Widget cards(var title,var desc) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteWhereYouGo(),
                ));
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Container(
            margin: EdgeInsets.fromLTRB(_w / 20, _w / 20, _w / 20, 0),
            padding: EdgeInsets.all(_w / 20),
            height: _w / 4.4,
            width: _w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.orange.withOpacity(.9),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(.5),
                  radius: _w / 15,
                  child: FlutterLogo(size: 30),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: _w / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textScaleFactor: 1.6,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                      Text(
                        desc,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(.8),
                        ),
                      )
                    ],
                  ),
                ),
                Icon(Icons.navigate_next_outlined)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_1 = Paint()
      ..color = AppColor.orange
      ..style = PaintingStyle.fill;

    Path path_1 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * .1, 0)
      ..cubicTo(size.width * .05, 0, 0, 20, 0, size.width * .08);

    Path path_2 = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width * .9, 0)
      ..cubicTo(
          size.width * .95, 0, size.width, 20, size.width, size.width * .08);

    Paint paint_2 = Paint()
      ..color = AppColor.orange
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    Path path_3 = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0);

    canvas.drawPath(path_1, paint_1);
    canvas.drawPath(path_2, paint_1);
    canvas.drawPath(path_3, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RouteWhereYouGo extends StatelessWidget {
  final Data data;
  RouteWhereYouGo({this.data});
  MapData map;
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context);
    return Scaffold(
        backgroundColor:Colors.black87,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: AppColor.orange,
        elevation: 50,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text(data.text,
            style: TextStyle(
                color: Colors.black.withOpacity(.7),
                fontWeight: FontWeight.w600,
                letterSpacing: 1)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black.withOpacity(.8)),
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      body: Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context),
          child: SafeArea(
          child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
                children: [
                Text('\n\n\n\n'),
                  Text(
                    data.text,
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
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      Helper.getAssetName("applogowhite.png", "virtual"),
                      fit: BoxFit.contain,
                      height: 200,
                      width: 200,
                    ),
                  ),
                  ListView(shrinkWrap: true, children: <Widget>[
                    new Row(children: <Widget>[
                      Text(
                      "Quantity \t\t\t  : ",
                      // style: Helper.getTheme(context).headline6,
                      style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.normal,
                          fontSize: 20
                      ),
                    ),
                      Expanded(child: Text(
                        data.qty,
                        // style: Helper.getTheme(context).headline6,
                        style: TextStyle(
                            color: AppColor.placeholderBg,
                            fontWeight: FontWeight.normal,
                            fontSize: 20
                        ),
                      ),)
                    ], crossAxisAlignment: CrossAxisAlignment.start),
                    new Row(children: <Widget>[
                        Text(
                        "Description : ",
                          // style: Helper.getTheme(context).headline6,
                          style: TextStyle(
                              color: AppColor.orange,
                              fontWeight: FontWeight.normal,
                              fontSize: 20
                          ),
                        ),
                      Expanded(child: Text(
                        data.desc,
                        // style: Helper.getTheme(context).headline6,
                        style: TextStyle(
                            color: AppColor.placeholderBg,
                            fontWeight: FontWeight.normal,
                            fontSize: 20
                        ),
                      ),)
                    ], crossAxisAlignment: CrossAxisAlignment.start),
                    new Row(children: <Widget>[
                      Text(
                        "Contact Number : ",
                        // style: Helper.getTheme(context).headline6,
                        style: TextStyle(
                            color: AppColor.orange,
                            fontWeight: FontWeight.normal,
                            fontSize: 20
                        ),
                      ),
                      Expanded(child: Text(
                        data.phone,
                        // style: Helper.getTheme(context).headline6,
                        style: TextStyle(
                            color: AppColor.placeholderBg,
                            fontWeight: FontWeight.normal,
                            fontSize: 20
                        ),
                      ))
                    ], crossAxisAlignment: CrossAxisAlignment.start),

                  ]),

                  Text(""),
                  Text('\n'),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            AppColor.orange
                        ),
                        side: MaterialStateProperty.all(BorderSide(width: 2.0, color: AppColor.orange)),
                      ),

                      onPressed: () async {
                        var url = Uri.parse("tel:"+data.phone);
                        try {
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        }
                        catch(e){
                          HapticFeedback.heavyImpact();
                          Fluttertoast.showToast(
                              msg: "Error occured while making call",
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
                          SizedBox(
                            width: 20,
                          ),

                          Text("Contact Now ",style: TextStyle(fontSize: 20,color: Colors.black)),
                          Icon(Icons.phone, color: Colors.black.withOpacity(.7)),

                        ],
                      ),
                    ),
                  ),
                  Text(""),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final mp = MapData(
                        lat:double.parse(data.lat),
                        long:double.parse(data.long)
                        );
                        print(mp.lat);
                        print(mp.long);
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>MapScreen1(mapdata: mp)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),

                          Text("View On Map ",style: TextStyle(fontSize: 20,color: Colors.black)),
                          Icon(Icons.map, color: Colors.black.withOpacity(.7)),

                        ],
                      // ), Text("View On Map",style: TextStyle(fontSize: 20,color: Colors.black)),
                    ),
                  )),
                  // SizedBox(
                  //   height: 50,
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: () async {
                  //       HapticFeedback.mediumImpact();
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => MapScreen1(mapdata: myController.text),
                  //         ),
                  //       );
                  //     },
                  //     child: Text("Contact Now",style: TextStyle(fontSize: 25)),
                  //
                  //   ),
                  // ),
                ]
            )
    )
      )
    )

    );
  }
}

