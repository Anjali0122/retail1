import 'dart:async';
import 'package:flutter/material.dart';
import 'package:retail/check.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 2), onDoneLoading);
  }
  onDoneLoading() async {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Check()));
}
@override
  Widget build(BuildContext context) {
  return new Scaffold(
    body: new Center(
      child: Image.asset('assets/logo.png'),
    ),
  );
}
}