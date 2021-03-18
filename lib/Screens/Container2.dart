import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';
import 'package:sports_news/widgets/CardOfMatch.dart';

import '../main.dart';

class Container2 extends StatefulWidget {
  static const con2="con2";
  @override
  _Container2State createState() => _Container2State();
}

class _Container2State extends State<Container2> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final apiProvidtrue=Provider.of<ApiProvider>(context);
    final apiProvidflase=Provider.of<ApiProvider>(context,listen: false);
    nav() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MyApp();
      }));
    }
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('EEEE d MMM ' 'yyyy');
    final String formatted = formatter.format(now);


    if (apiProvidtrue.isloading) {
      apiProvidflase
          .getMatchesOfTheDay()
          .then((_) => apiProvidflase
              .isloading = false).catchError((e) {
        if (e == "Failed host lookup: 'v3.football.api-sports.io'")
          return flushbar(() => nav(), context);
        else if (e == "Invalid value") return ShowDialogg(context);
      });
    }
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/background2.jpg"),
              fit: BoxFit.cover)),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Image.asset("assets/images/logo2.png"),
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Matchday Live",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
                Text(
                  "${formatted}",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white),
                )
              ],
            ),
          ),
          if (apiProvidtrue.isloading == true)
            Container(
              height: MediaQuery.of(context).size.height/2,
              child: SpinKitCubeGrid (
                duration: Duration(milliseconds: 900),
                color: Color.fromRGBO(55, 0, 60, 1.0),
                size: 120,
              ),
            )
          else if (apiProvidtrue.fixture.isEmpty)
            Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Match For ToDay",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white70),
                    ),
                  ],
                ))
          else
            ...apiProvidtrue
                .fixture
                .map((item) => CardOfMatch(item))
                .toList()
        ],
      ),
    );
  }

  void flushbar(nav(), BuildContext context) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      mainButton: Builder(
        builder: (ctx) {
          return FlatButton(
            onPressed: () {
              nav();
            },
            child: Text("close"),
          );
        },
      ),
      title: "Error",
      message: "Check Your internet",
      backgroundColor: Colors.green,
      icon: Icon(Icons.signal_cellular_connected_no_internet_4_bar),
    ).show(context);
  }

  void ShowDialogg(BuildContext context) {
    final alert = AlertDialog(
      elevation: 10,
      title: Text('Some Thing Went Wrong'),
      content: Container(
        height: 150,
        child: Column(
          children: [
            Divider(
              color: Colors.black,
            ),
            Text("this is Dialog Body"),
            SizedBox(
              height: 7,
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, child: alert, barrierDismissible: false);
  }
}
