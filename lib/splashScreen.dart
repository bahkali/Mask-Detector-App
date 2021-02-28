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
      title: Text(
        'Mask Detector App',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black
        ),
      ),
    );
  }
}
