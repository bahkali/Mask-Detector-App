import 'package:facemaskapp/homePage.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashPage extends StatefulWidget {
  @override
  _MySplashPageState createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: HomePage(),
      title: Text(
        'Mask Detector App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black
        ),
      ),
      image: Image.asset("assets/splash.png"),
      photoSize: 150,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text(
        "From KmadStudio by Kaly",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0
        ),
      ),
    );
  }
}
