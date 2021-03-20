import 'package:flutter/material.dart';
import 'package:sports_news/Screens/Container1.dart';
import 'package:sports_news/Screens/Container2.dart';
import 'package:sports_news/Screens/Container3.dart';


class bottomProvider with ChangeNotifier{
  int currentIdex=0;

  getIndex(int index){

    currentIdex=index;
    notifyListeners();
  }

  List<Widget> ListOfcontainers=[Container1(),Container2(),Container3()];

}