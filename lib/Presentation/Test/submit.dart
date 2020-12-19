import 'package:flutter/material.dart';
import 'package:parkinsin_disease_detection/Presentation/Home/home.dart';

import 'package:parkinsin_disease_detection/Presentation/image_picker/ImagePicker.dart';

class resultpage extends StatefulWidget {
  var output = List.generate(10, (l) => List(2), growable: false);
  resultpage({Key key, @required this.output}) : super(key: key);
  @override
  _resultpageState createState() => _resultpageState(output);
}

class _resultpageState extends State<resultpage> {
  String message;
  String image = "images/good.png";

  var output = List.generate(10, (l) => List(2), growable: false);
  _resultpageState(this.output);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 15.0,
                        ),
                        child: Center(
                          child: Text(
                            "Thank you for your time",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: "Quando",
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: () {
                    print(output);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
                  },
                  child: Text(
                    "Retake",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                ),
                SizedBox(width: 40),
                OutlineButton(
                  onPressed: () {
                    print(output);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ));
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
