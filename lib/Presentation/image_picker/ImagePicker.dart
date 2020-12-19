import 'dart:io';

import 'package:parkinsin_disease_detection/Presentation/result/result.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tflite/tflite.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _picker = ImagePicker();
  List _outputs;
  File _selectedFile;
  bool _inProcess = false;
  String output = "Healthy";

  @override
  void initState() {
    super.initState();

    loadModel().then((value) {
      setState(() {});
      print("model loaded1");
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
    print("model loaded");
  }

  classifyImage(File image) async {
    var outputt = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _outputs = outputt;
      output = _outputs[0]["label"];
      print(_outputs);
      print("------");
      print(_outputs[0]["label"]);
      print("------");
      print(output);
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Widget getImageWidget() {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile,
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        "assets/placeholder.png",
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    }
  }

  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    PickedFile image = await _picker.getImage(source: source);

    this.setState(() {
      _selectedFile = File(image.path);
      //_selectedFile =  convertImage(_selectedFile);
      _inProcess = false;
    });
    // if (image != null) {
    //   File cropped = await ImageCropper.cropImage(
    //       sourcePath: image.path,
    //       aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    //       compressQuality: 100,
    //       maxWidth: 700,
    //       maxHeight: 700,
    //       compressFormat: ImageCompressFormat.jpg,
    //       androidUiSettings: AndroidUiSettings(
    //         toolbarColor: Colors.deepOrange,
    //         toolbarTitle: "RPS Cropper",
    //         statusBarColor: Colors.deepOrange.shade900,
    //         backgroundColor: Colors.white,
    //       ));

    //   this.setState(() {
    //     _selectedFile = cropped;
    //     _inProcess = false;
    //   });
    // } else {
    //   this.setState(() {
    //     _inProcess = false;
    //   });
    // }
  }

  void _uploadFile(File filePath) async {
    // Get base file name
    print("checking");
    // String fileName = basename(filePath.path);
    // print("File base name: $fileName");

    try {
      // FormData formData =
      //     new FormData.from({"file": await MultipartFile.fromFile(filePath, fileName)});
      print("step 1");
      String fileName = filePath.path.split('/').last;
      FormData formData = FormData.fromMap(
          {"file": await MultipartFile.fromFile(filePath.path)});
      print("step 2");

      final response = await Dio().post(
          "https://parkinson-prediction-api.herokuapp.com/predict",
          data: formData);

      // print("File upload response: $response");
      print("step 11");
      print(response);
      print("step 11");
      output = response.toString();
      print(output);

      // Show the incoming message in snakbar

    } catch (e) {
      print("Exception Caught: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF14171A),
        body: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "Sketch spiral on white blank page",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF4f5f8fa),
                        fontFamily: "Alike"),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
                getImageWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    OutlineButton(
                      color: Color(0xFF4e5a63),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      child: Text(
                        "Camera",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF4f5f8fa),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 25.0,
                      ),
                      borderSide:
                          BorderSide(width: 3.0, color: Color(0xFF838a8f)),
                      splashColor: Color(0xFF4e5a63),
                    ),
                    OutlineButton(
                      color: Color(0xFF4e5a63),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF4f5f8fa),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 25.0,
                      ),
                      borderSide:
                          BorderSide(width: 3.0, color: Color(0xFF838a8f)),
                      splashColor: Color(0xFF4e5a63),
                    )
                  ],
                ),
                SizedBox(height: 35),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                        color: Color(0xFF4e5a63),
                        onPressed: () async {
                          if (_selectedFile != null) {
                            print("_selectedFile");

                            await _uploadFile(_selectedFile);
                            print("donee");
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => Result(output: output),
                            ));
                          }
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF4f5f8fa),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 25.0,
                        ),
                        borderSide:
                            BorderSide(width: 3.0, color: Color(0xFF838a8f)),
                        splashColor: Color(0xFF4e5a63),
                      )
                    ])
              ],
            ),
            (_inProcess)
                ? Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.95,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Center()
          ],
        ));
  }
}
