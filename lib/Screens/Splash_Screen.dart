import 'package:flutter/material.dart';
import 'package:sports_news/main.dart';
import 'file:///E:/Mobile/Flutter/Projects/sports_news/lib/Screens/Container1.dart';
import 'file:///E:/Mobile/Flutter/Projects/sports_news/lib/Screens/Container2.dart';
import 'file:///E:/Mobile/Flutter/Projects/sports_news/lib/Screens/Container3.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  BuildContext ctxx;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),
        () => Navigator.of(ctxx).pushReplacementNamed(MyApp.routename));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (ctx) {
          ctxx = ctx;
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage("assets/GIF/premier.gif"),
                    fit: BoxFit.cover)),
          );
        },
      ),
      routes: {
        MyApp.routename: (context) => MyApp(),
        Container1.con1:(context)=>Container1(),
        Container2.con2:(context)=>Container2(),
        Container3.con3:(context)=>Container3(),

      },
    );
  }
}
