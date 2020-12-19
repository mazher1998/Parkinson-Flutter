import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:parkinsin_disease_detection/Presentation/Test/submit.dart';

class getjson extends StatelessWidget {
  // accept the langname as a parameter

  String assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    assettoload = "assets/python.json";
  }

  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assettoload is avialable to the DefaultAssetBuilder
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return quizpage(mydata: mydata);
        }
      },
    );
  }
}

class quizpage extends StatefulWidget {
  final List mydata;

  quizpage({Key key, @required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  final List mydata;
  _quizpageState(this.mydata);
  var output = List.generate(10, (l) => List(2), growable: false);
  int count = 0;
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;

  int i = 1;
  bool disableAnswer = false;
  // extra varibale to iterate
  int j = 1;

  Map<String, Color> btncolor = {
    "a": Colors.indigoAccent,
    "b": Colors.indigoAccent,
    "c": Colors.indigoAccent,
  };

  // code inserted for choosing questions randomly
  // to create the array elements randomly use the dart:math module
  // -----     CODE TO GENERATE ARRAY RANDOMLY

  //   var random_array;
  //   var distinctIds = [];
  //   var rand = new Random();
  //     for (int i = 0; ;) {
  //     distinctIds.add(rand.nextInt(10));
  //       random_array = distinctIds.toSet().toList();
  //       if(random_array.length < 10){
  //         continue;
  //       }else{
  //         break;
  //       }
  //     }
  //   print(random_array);

  // ----- END OF CODE
  // var random_array = [1, 6, 7, 2, 4, 10, 8, 3, 9, 5];

  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void nextquestion() {
    setState(() {
      if (j < 10) {
        i++;
        j++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(output: output),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;

      disableAnswer = false;
    });
  }

  void checkanswer(String k) {
    output[count][0] = i.toString();
    output[count][1] = mydata[1][i.toString()][k];
    count++;

    colortoshow = right;
    setState(() {
      // applying the changed color to the particular button that was selected
      btncolor[k] = colortoshow;

      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(Duration(seconds: 2), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Alike",
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Quizstar",
                  ),
                  content: Text("You Can't Go Back At This Stage."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Ok',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: "Quando",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: AbsorbPointer(
                absorbing: disableAnswer,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
