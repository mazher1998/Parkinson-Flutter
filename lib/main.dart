import 'package:flutter/material.dart';

import 'Presentation/Splash/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parkinson Disease Detection',
      
      home: splashscreen(),
      debugShowCheckedModeBanner: false, //REMOVING THE BANNER
    );
  }
}
