import 'package:flutter/material.dart';
import 'package:monkey_app_demo/const/colors.dart';

import 'package:monkey_app_demo/screens/signUpScreen.dart';
import 'package:monkey_app_demo/utils/helper.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = "/introScreen";

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  var _controller;
  int count;
  final List<Map<String, String>> _pages = [
    {
      "image": "vector1.png",
      "title": "Help Others",
      "desc":
          "At The End, It's Not About What You Have Or Even What You've Accomplished. It's About Who You've Lifted Up, Who You've Made Better. It's About What You've Given Back"
    },
    {
      "image": "vector1.png",
      "title": "Help Others",
      "desc": "when We Give Cheerfully And Accept Gratefully, Everyone Is Blessed."
    },
    {
      "image": "vector1.png",
      "title": "Love Helping",
      "desc":
          "No One Has Ever Become Poor By Giving"
    },
  ];

  @override
  void initState() {
    _controller = new PageController();
    count = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Spacer(),
                Container(
                  height: 400,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() {
                        count = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(Helper.getAssetName(
                          _pages[index]["image"], "virtual"));
                    },
                    itemCount: _pages.length,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          count == 0 ? AppColor.orange : AppColor.placeholder,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          count == 1 ? AppColor.orange : AppColor.placeholder,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          count == 2 ? AppColor.orange : AppColor.placeholder,
                    )
                  ],
                ),
                Spacer(),
                Text(
                  _pages[count]["title"],
                  style: Helper.getTheme(context).headline6,
                ),
                Spacer(),
                Text(
                  _pages[count]["desc"],
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>SignUpScreen()));
                        // Navigator.of(context)
                        //     .pushReplacementNamed(SignUpScreen.routeName);
                      },
                      child: Text("Next")),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
