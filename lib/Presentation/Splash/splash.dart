import 'dart:async';
import 'package:flutter/material.dart';
import 'package:parkinsin_disease_detection/Presentation/Login_Screen/login.dart';
import 'package:parkinsin_disease_detection/Presentation/result/FadeAnimation.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    });
  }

  // added test yourself
  // and made the text to align at center
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14171A),
      body: Center(
        child: Column(children: <Widget>[
          SizedBox(height: 160),
          FadeAnimation(
            1,
            IconButton(
              icon: Icon(Icons.wb_sunny),
              iconSize: 100.0,
              color: Color(0xFF4f5f8fa),
              onPressed: () {},
            ),
          ),
          SizedBox(height: 15),
          FadeAnimation(
            2,
            Text(
              "PARKINSON'S",
              style: TextStyle(
                fontSize: 60.0,
                color: Color(0xFF4f5f8fa),
                fontFamily: "Satisfy",
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          FadeAnimation(
            3,
            Text('Disease Detection',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF4f5f8fa),
                  fontFamily: "Satisfy",
                )),
          ),
        ]),
      ),
    );
  }
}
