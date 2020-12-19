import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:parkinsin_disease_detection/Presentation/Home/home.dart';
import 'package:parkinsin_disease_detection/Presentation/result/FadeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Result extends StatefulWidget {
  String output;
  Result({Key key, @required this.output}) : super(key: key);
  @override
  _ResultState createState() => _ResultState(output);
}

class _ResultState extends State<Result> {
  String output;
  _ResultState(this.output);
  @override
  Widget build(BuildContext context) {
    print(output);
    return Scaffold(
        backgroundColor: Color(0xFF4e5a63),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (output == "Healthy")
                              ? AssetImage('assets/background.png')
                              : AssetImage(''),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 20,
                        width: 80,
                        height: 180,
                        child: FadeAnimation(
                            2,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 145,
                        width: 80,
                        height: 120,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 15,
                        width: 200,
                        height: 520,
                        child: FadeAnimation(
                            3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: (output == "Healthy")
                                          ? AssetImage('')
                                          : AssetImage('assets/doctor.png'))),
                            )),
                      ),
                      Positioned(
                        right: 30,
                        top: 30,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/clock.png'))),
                            )),
                      ),
                      Positioned(
                        left: 50,
                        child: FadeAnimation(
                            3,
                            Container(
                              margin: EdgeInsets.only(top: 230),
                              child: Text(
                                output,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: <Widget>[
                            FadeAnimation(
                              4.5,
                              Text(
                                (output == "Healthy")
                                    ? "Thank you for Taking this test."
                                    : "You need to vist to Doctor.",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10),
                            FadeAnimation(
                              5.5,
                              Text(
                                (output == "Healthy")
                                    ? "Our test has deemed you healthy for further "
                                    : "Get yourself checked up as soon as possible.",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 5),
                            FadeAnimation(
                              6,
                              Text(
                                (output == "Healthy")
                                    ? "for further satisfaction go see the doctor"
                                    : "There is always a option to call a Doctor at home.",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      FadeAnimation(
                        7,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                                width: 120, // specific value
                                child: RaisedButton(
                                  textColor: Color(0xFF838a8f),
                                  color: Color(0xFF4f5f8fa),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await saveresult(output);
                                    print("success");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  },
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                )),
                            SizedBox(
                                width: 120, // specific value
                                child: RaisedButton(
                                  textColor: Color(0xFF838a8f),
                                  color: Color(0xFF4f5f8fa),
                                  child: Text(
                                    "Skip",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  },
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

saveresult(title) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("token");
  print(token);
  Map<String, String> headers = {};
  headers['token'] = token;
  headers['Content-Type'] = 'application/json; charset=UTF-8';
  var url = "https://pdd-backend.herokuapp.com/api/user/addresult";
  final http.Response response = await http.put(
    url,
    headers: headers,
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  var parse = json.decode(response.body);
  print(parse);
  print(title);
  // print(parse);
  // if (response.statusCode == 201) {
  // } else {
  //   throw Exception('Failed to create album.');
  // }
}
