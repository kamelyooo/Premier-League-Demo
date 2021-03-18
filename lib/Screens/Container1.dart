import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';
import 'package:sports_news/widgets/cardOfLeagueTable.dart';

import '../main.dart';

class Container1 extends StatelessWidget {
  static const con1 = "con1";

  @override
  Widget build(BuildContext context) {

    final apiProvidtrue=Provider.of<ApiProvider>(context);
    final apiProvidflase=Provider.of<ApiProvider>(context,listen: false);
    nav() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MyApp();
      }));
    }

    if (apiProvidtrue.isloadingStandings) {
      apiProvidflase
          .getstandingsData()
          .then((_) => apiProvidflase
              .isloadingStandings = false)
          .catchError((e) {
        if (e == "Failed host lookup: 'v3.football.api-sports.io'")
          return flushbar(() => nav(), context);
        else if (e == "Invalid value") return ShowDialogg(context);
      });
    }
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/images/background2.jpg"),
              fit: BoxFit.cover)),
      child: apiProvidtrue.isloadingStandings
          ?Container(
        height: MediaQuery.of(context).size.height/2,
        child: SpinKitCubeGrid (
          duration: Duration(milliseconds: 900),
          color: Color.fromRGBO(55, 0, 60, 1.0),
          size: 120,
        ),
      )
          : ListView(
              children: [
                Container(
                  color: Colors.white,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "League Table",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color.fromRGBO(55, 0, 60, 1)),
                      ),
                      Image.asset('assets/images/logo3.png')
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        color: Color.fromRGBO(235, 235, 235, 1),
                        height: 40,
                        width: double.infinity,
                        padding: EdgeInsets.only(left: 7, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 2, child: Text("Pos")),
                            Expanded(flex: 2, child: Text("Club")),
                            Expanded(child: Text("P")),
                            Expanded(child: Text("GD")),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Text("Pts"),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ...apiProvidtrue.standings.map((item) {
                  return cardOfLeagueTable(
                    item: item,
                  );
                }).toList()
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


