import 'package:flutter/material.dart';
import 'package:parkinsin_disease_detection/Presentation/Login_Screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1a1a1a),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(),
                    ],
                  ),
                  SizedBox(height: 15),
                  new Row(children: <Widget>[
                    SizedBox(height: 15),
                    Text("PARKINSON'S",
                        style: TextStyle(
                            fontSize: 37,
                            color: Color(0xFF4f5f8fa),
                            fontFamily: "Satisfy")),
                  ], crossAxisAlignment: CrossAxisAlignment.start),
                  SizedBox(height: 7),
                  new Row(children: <Widget>[
                    Text("Disease Detection",
                        style: TextStyle(
                            fontSize: 32,
                            color: Color(0xFF4f5f8fa),
                            fontFamily: "Satisfy")),
                  ], crossAxisAlignment: CrossAxisAlignment.start)
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xFF14171A),
              ),
            ),
            // Row(
            //   children: <Widget>[
            //     Container(height: 1.0, width: 303.0, color: Colors.grey),
            //   ],
            // ),
            SizedBox(height: 10),
            // Row(
            //   children: <Widget>[
            //     Text("      Other",
            //         style: TextStyle(
            //             color: Color(0xFF4f5f8fa),
            //             fontWeight: FontWeight.bold)),
            //   ],
            // ),
            FlatButton.icon(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setString('token', null);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              icon: Icon(Icons.exit_to_app, color: Color(0xFF4f5f8fa)),
              label: Text('Logout',
                  style: TextStyle(
                      color: Color(0xFF4f5f8fa), fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
