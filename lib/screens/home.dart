import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import '../const/colors.dart';

import 'FindItems.dart';
import 'Mapscreen.dart';


import 'addDonor.dart';
import 'loginScreen.dart';

class MyCustomUI extends StatefulWidget {
  @override
  _MyCustomUIState createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<MyCustomUI> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller2;
  Animation<double> _animation;
  Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 0, end: -50).animate(CurvedAnimation(
        parent: _controller2, curve: Curves.fastLinearToSlowEaseIn));

    _controller.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar(),
      body: Stack(
        children: [
          // background color
          backgroundColor(),
          // MyCustomWidget1(),
          /// ListView
          ListView(
            physics:
            BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              SizedBox(height: _w / 5.5),

              card('Donate Items', 'Happiness doesn’t result from what we get, but from what we give.', Icons.card_giftcard_rounded,
                  AddDonation()),

              card('Find Items', 'Nothing makes one feel so strong as a call for help', Icons.search_outlined,
                  FindItems()),
              // card('Find Items', 'Nothing makes one feel so strong as a call for help', Icons.search_outlined,
              //     RouteWhereYouGo()),
              // card('Example example example', 'Example', Icons.favorite,
              //     RouteWhereYouGo()),
              // card('Example example example', 'Example', Icons.favorite,
              //     RouteWhereYouGo()),
              // card('Example example example', 'Example', Icons.favorite,
              //     RouteWhereYouGo()),
              // card('Example example example', 'Example', Icons.favorite,
              //     RouteWhereYouGo()),
              // card('Example example example', 'Example', Icons.favorite,
              //     RouteWhereYouGo()),
              // card('Example example example', 'Example', Icons.favorite,
              //     RouteWhereYouGo()),
              // card('Example example example', 'Example', Icons.favorite,
              //     RouteWhereYouGo()),
            ],
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    double _w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(double.infinity, kToolbarHeight),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.tealAccent.withOpacity(.7),
          elevation: 0,
          title: Text(
            ' Helping Hands',
            style: TextStyle(
              fontSize: _w / 15,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Sign out',
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.logout, color: Colors.black.withOpacity(.7)),
              onPressed: () async {
                HapticFeedback.lightImpact();
                await FirebaseAuth.instance.signOut();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            Text(' '),
          ],
        ),
      ),
    );
  }

  Widget card(String title, String subtitle, IconData icon, Widget route) {
    double _w = MediaQuery.of(context).size.width;
    return Opacity(
      opacity: _animation.value,
      child: Transform.translate(
        offset: Offset(0, _animation2.value),
        child: Container(
          height: _w / 1.4,
          width: _w,
          padding: EdgeInsets.fromLTRB(_w / 20, 0, _w / 20, _w / 20),
          child: InkWell(
            highlightColor: Colors.tealAccent,
            splashColor: Colors.tealAccent,
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => route));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.2),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.all(
                      color: Colors.white.withOpacity(.1), width: 1)),
              child: Padding(
                padding: EdgeInsets.all(_w / 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: _w / 3,
                      width: _w / 3,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        icon,
                        color: Colors.tealAccent,
                        size: _w / 3,
                      ),
                    ),
                    SizedBox(width: _w / 40),
                    SizedBox(
                      width: _w / 2.05,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _w / 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              wordSpacing: 1,
                            ),
                          ),
                          Text(
                            subtitle,
                            maxLines: 4,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(1),
                              fontSize: _w / 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Tap to know more',
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _w / 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class backgroundColor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xc7f800),
        //     // Color(0xb8000000),
        //     // Color(0xff21f3d3),
        //     AppColor.orange,
        //     // Color(0xba21f3c2),
        //   ],
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        // ),
      ),
    );
  }
}

class RouteWhereYouGo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 50,
        centerTitle: true,
        shadowColor: Colors.black.withOpacity(.5),
        title: Text(
          'EXAMPLE PAGE',
        ),
      ),
    );
  }
}



class MyCustomWidget1 extends StatefulWidget {
  @override
  _MyCustomWidgetState createState() => new _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget1> {
  double _page = 1;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PageController pageController;
    pageController = PageController(initialPage: 2);
    pageController.addListener(
          () {
        setState(
              () {
            _page = pageController.page;
          },
        );
      },
    );

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SizedBox(
              height: width,
              width: width * .95,
              child: LayoutBuilder(
                builder: (context, boxConstraints) {
                  List<Widget> cards = new List();

                  for (int i = 0; i <= 1; i++) {
                    double currentPageValue = i - _page;
                    bool pageLocation = currentPageValue > 0;

                    double start = 20 +
                        max(
                            (boxConstraints.maxWidth - width * .75) -
                                ((boxConstraints.maxWidth - width * .75) / 2) *
                                    -currentPageValue *
                                    (pageLocation ? 9 : 1),
                            0.0);

                    var customizableCard = Positioned.directional(
                      top: 20 + 30 * max(-currentPageValue, 0.0),
                      bottom: 20 + 30 * max(-currentPageValue, 0.0),
                      start: start,
                      textDirection: TextDirection.ltr,
                      child: Container(
                          height: width * .70,
                          width: width * .70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    blurRadius: 10)
                              ]),
                          child: Text("Hello! I am in the container widget", style: TextStyle(fontSize: 25)),
                    ),
                    );
                    cards.add(customizableCard);
                  }
                  return Stack(children: cards);
                },
              ),
            ),
            Positioned.fill(
              child: PageView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: 2,
                controller: pageController,
                itemBuilder: (context, index) {
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}