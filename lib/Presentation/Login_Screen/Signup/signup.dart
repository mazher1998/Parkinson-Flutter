import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:parkinsin_disease_detection/Presentation/Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onSignin;

  RegisterForm({Key key, this.onSignin}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _codeController = TextEditingController();

  var firstName;

  var lastName;

  var number;

  var email;

  var password;

  final _registerKey = GlobalKey<FormState>();

  signup(firstName, lastName, number, email, password) async {
    var url = "https://pdd-backend.herokuapp.com/api/user/signup";
    final http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': firstName,
        'lastname': lastName,
        'number': number,
        'email': email,
        'password': password,
      }),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int counter = (prefs.getInt('counter') ?? 0) + 1;
    // print('Pressed $counter times.');
    var parse = jsonDecode(response.body);
    print(parse["token"]);
    if (parse["token"] == null) {
      if (parse["error"][0]["msg"] != null) {
        _showMyDialog(parse["error"][0]["msg"]);
      }
    }
    await prefs.setString('token', parse["token"]);
  }

  Future<void> _showMyDialog(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF4e5a63),
          title: Text(
            'Sign Up Failed',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF4f5f8fa)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4f5f8fa))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Try Again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Form(
        key: _registerKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10, width: 300),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                              style: TextStyle(
                                  fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                              autocorrect: false,
                              onChanged: (value) {
                                firstName = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'First Name',
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF4f5f8fa)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                              style: TextStyle(
                                  fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                              autocorrect: false,
                              onChanged: (value) {
                                lastName = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Last Name',
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF4f5f8fa)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                              style: TextStyle(
                                  fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                              autocorrect: false,
                              onChanged: (value) {
                                number = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF4f5f8fa)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                              style: TextStyle(
                                  fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                              autocorrect: false,
                              onChanged: (value) {
                                email = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'ID',
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF4f5f8fa)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 9),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                              style: TextStyle(
                                  fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                              autocorrect: false,
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Color(0xFF4f5f8fa)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF4f5f8fa)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RaisedButton(
                            textColor: Color(0xFF4f5f8fa),
                            color: Color(0xFF838a8f),
                            child: Text("REGISTER NOW"),
                            onPressed: () async {
                              print(firstName);
                              await signup(
                                  firstName, lastName, number, email, password);

                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String token = prefs.getString("token");
                              if (token != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()),
                                );
                              }
                            },
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: 42),
      InkWell(
        onTap: widget.onSignin,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Already have an account?",
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'SFProTextSemiBold',
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }
}
