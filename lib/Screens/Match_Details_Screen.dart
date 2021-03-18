

import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';
import 'package:sports_news/widgets/RowofStatics.dart';

import '../main.dart';

class MatchDetails extends StatefulWidget {
  final idHome;
  final idAway;
  final nameHome;
  final nameAway;
  final logoHome;
  final logoAway;
  final goalsHome;
  final goalsAway;
  final FixturesId;
  final staduim;
  final date;

  const MatchDetails({
    @required this.idHome,
    @required this.idAway,
    @required this.nameHome,
    @required this.nameAway,
    @required this.logoHome,
    @required this.logoAway,
    @required this.goalsHome,
    @required this.goalsAway,
    @required this.FixturesId,
    @required this.staduim,
    @required this.date,
  });

  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {


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
    if (apiProvidtrue.isloadingStatistics) {
      apiProvidflase.getStatisticsHome(widget.FixturesId, widget.idHome);
      apiProvidflase.getStatisticsAway(widget.FixturesId, widget.idAway)
          .then((_) => apiProvidflase
          .isloadingStatistics = false).catchError((e) {
        if (e == "Failed host lookup: 'v3.football.api-sports.io'")
          return flushbar(() => nav(), context);
        else if (e == "Invalid value") return ShowDialogg(context);
      })
      ;
    }
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('EEEE d MMM ');
    final String formatted = formatter.format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.nameHome} VS ${widget.nameAway}"),
        backgroundColor: Color.fromRGBO(55, 0, 60, 1),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(84, 0, 92, 1.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  ExactAssetImage("assets/images/staduim.webp"),
                              fit: BoxFit.cover)),
                    ),
                    //header Date and stadium name
                    Container(
                      height: 50,
                      color: Color.fromRGBO(102, 0, 108, 0.5),
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      //Date and stadium
                      child: Padding(
                        padding: const EdgeInsets.only(left:14),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatted,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                            Row(children: [
                              Icon(Icons.account_balance_sharp,color: Colors.white,),
                              Text(widget.staduim.toString(),style: TextStyle(fontSize: 15,color: Colors.white),)
                            ],)
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              //goals and names
              Container(
                width: double.infinity,
                height: 60,
                color:Color.fromRGBO(55, 0, 60, 1) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            color: Colors.white,
                            height: 60,
                            child: ClipRRect(
                              child: Image.network(
                                widget.logoHome,
                                height: 40,
                                width: 50,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(

                                widget.nameHome,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,color: Colors.white,fontSize: 17),
                               textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.goalsHome == null ? Text("--", style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),) : Text(
                                  widget.goalsHome.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                Text(
                                  '-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),
                                ),
                                SizedBox(
                                  width: 1,
                                ),
                                widget.goalsAway == null ? Text("--",style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),) : Text(
                                  widget.goalsAway.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 25,color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Text(

                                widget.nameAway.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17,color: Colors.white),
                                textAlign: TextAlign.end,

                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(2),
                            color: Colors.white,
                            height: 60,
                            child: ClipRRect(

                              child: Image.network(
                                widget.logoAway,
                                height: 40,
                                width: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 7,),
              if (apiProvidtrue.isloadingStatistics == true)
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: SpinKitCubeGrid (
                    duration: Duration(milliseconds: 900),
                    color: Color.fromRGBO(55, 0, 60, 1.0),
                    size: 120,
                  ),
                )
              else if (apiProvidtrue.StatisticsHome.isEmpty||
                  apiProvidtrue.StatisticsAway.isEmpty)
                Container(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "The Match Doesn't Start",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.white70),
                        ),
                      ],
                    ))
              else
              Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                  RowOfStatics(type: 0),
                  RowOfStatics(type: 1),
                  RowOfStatics(type: 2),
                  RowOfStatics(type: 3),
                  RowOfStatics(type: 4),
                    RowOfStatics(type: 5),
                    RowOfStatics(type: 6),
                    RowOfStatics(type: 7),
                    RowOfStatics(type: 8),
                    RowOfStatics(type: 9),
                    RowOfStatics(type: 10),
                    RowOfStatics(type: 11),
                    RowOfStatics(type: 12),
                    RowOfStatics(type: 13),
                    RowOfStatics(type: 14),
                  ],
                ),
              )
            ],
          ),
        ),
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
