

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';
import 'package:sports_news/Providers/bottomProvider.dart';
import 'package:sports_news/Screens/Splash_Screen.dart';
import 'package:sports_news/my_flutter_app_icons.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ApiProvider>(
          create: (_) => ApiProvider(),
        ), ChangeNotifierProvider<bottomProvider>(
          create: (_) => bottomProvider(),
        )
      ],
      child: SplashScreen(),
    ),
  );
}

class MyApp extends StatelessWidget {

  static const routename="MainScreen";
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor:  Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:Provider.of<bottomProvider>(context).ListOfcontainers[Provider.of<bottomProvider>(context).currentIdex] ,
      bottomNavigationBar: Builder(
        builder: (ctx){
          return  BottomNavigationBar(
            selectedItemColor:Color.fromRGBO(48,1,53,1)
            ,items: [
          BottomNavigationBarItem(icon: Icon(MyFlutterApp.logoicon),title: Text('LT',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
          BottomNavigationBarItem(icon: Icon(Icons.list),title: Text('MatchDay',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined),title: Text('Statistics',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold))),
          ],
          onTap:(index)=>Provider.of<bottomProvider>(ctx,listen: false).getIndex(index) ,
          currentIndex: Provider.of<bottomProvider>(ctx).currentIdex,);
        },

      ),
    );
  }
}