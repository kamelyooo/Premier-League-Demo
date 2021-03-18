import 'package:flutter/material.dart';
import 'file:///E:/Mobile/Flutter/Projects/sports_news/lib/Screens/Container1.dart';
import 'file:///E:/Mobile/Flutter/Projects/sports_news/lib/Screens/Container2.dart';
import 'file:///E:/Mobile/Flutter/Projects/sports_news/lib/Screens/Container3.dart';

class bottomProvider with ChangeNotifier{
  int currentIdex=0;

  getIndex(int index){

    currentIdex=index;
    notifyListeners();
  }

  List<Widget> ListOfcontainers=[Container1(),Container2(),Container3()];

}