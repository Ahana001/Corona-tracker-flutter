import 'package:covid_tracker/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
      seconds: 15,
      backgroundColor: Colors.black,
      image: Image.asset("assets/loading.gif"),
      loaderColor: Colors.white,
      photoSize: 100,
      navigateAfterSeconds: HomePage()
        ));
  }
}
