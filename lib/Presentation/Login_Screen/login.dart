import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Login/loogin.dart';
import 'Signup/signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool signup = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF14171A),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 90),
              IconButton(
                icon: Icon(Icons.wb_sunny),
                iconSize: 90.0,
                color: Color(0xFF4f5f8fa),
                onPressed: () {},
              ),
              SizedBox(height: 15),
              Text("PARKINSON'S",
                  style: TextStyle(
                    fontSize: 56,
                    height: 1,
                    color: Color(0xFF4f5f8fa),
                    fontFamily: "Satisfy",
                  )),
              SizedBox(height: 15),
              Text('Disease Detection',
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: "Satisfy",
                      height: 1,
                      color: Color(0xFF4f5f8fa))),
              Visibility(
                visible: !signup,
                child: LoginForm(onSignup: () {
                  setState(() {
                    signup = true;
                  });
                }),
              ),
              Visibility(
                visible: signup,
                child: RegisterForm(
                  onSignin: () {
                    setState(() {
                      signup = false;
                    });
                  },
                ),
              ),
              //SizedBox(height: 444),

              SizedBox(height: 5)
            ],
          ),
        ),
      ),
    );
  }
}
