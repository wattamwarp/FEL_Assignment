import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:xyz_app/pages/news.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage())));

  }
  //AssetImage pizzaAsset = AssetImage('images/fel.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Image.asset('images/fel.jpg'),
        ),
      ),
    );
  }
}