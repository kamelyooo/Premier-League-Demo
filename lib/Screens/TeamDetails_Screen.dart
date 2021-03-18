import 'dart:async';
import 'dart:ffi';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';
import 'package:sports_news/widgets/CardOfTeamDetails.dart';

class TeamDetails extends StatefulWidget {
  final teamId;
  final teamName;
  final teamlogo;

  const TeamDetails({this.teamId, this.teamName, this.teamlogo});

  @override
  _TeamDetailsState createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> {
  bool isloadingTeamDetails = true;

  Map TeamDetailss = {};

  @override
  Widget build(BuildContext context) {
    final apiProvidflase = Provider.of<ApiProvider>(context, listen: false);
    nav() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return TeamDetails();
      }));
    }

    if (isloadingTeamDetails) {
      apiProvidflase.getTeamDetails(widget.teamId).then((value) {
        setState(() {
          TeamDetailss = value;

        });

        return isloadingTeamDetails = false;
      }).catchError((e) {
        if (e == "Failed host lookup: 'v3.football.api-sports.io'")
          return flushbar(() => nav(), context);
        else if (e == "Invalid value") return ShowDialogg(context);
      });
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            excludeHeaderSemantics: true,
            titleSpacing: -15,
            backgroundColor: Color.fromRGBO(55, 0, 60, 1),
            expandedHeight: 150,
            pinned: true,
            title: Container(
                width: 100,
                child: Text(
                  "${widget.teamName}",
                  overflow: TextOverflow.fade,
                )),
            flexibleSpace: Image.network(
              '${widget.teamlogo}',
              fit: BoxFit.contain,
            ),
          ),
          SliverList(
            delegate:isloadingTeamDetails?SliverChildListDelegate(
              [Container(
                height: MediaQuery.of(context).size.height/2,
                child: SpinKitCubeGrid (
                  duration: Duration(milliseconds: 900),
                  color: Color.fromRGBO(55, 0, 60, 1),
                  size: 120,
                ),
              )]
            ): SliverChildListDelegate([
              Container(
                color: Color.fromRGBO(235, 235, 235, 1),
                height: 65,
                width: double.infinity,
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'HOME',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'AWAY',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      'ALL',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
                    ),
                  ],
                ),
              ),
              CardOfTeamDetails(
                  type: "Games Played",
                  Home: TeamDetailss['fixtures']['played']['home'],
                  Away: TeamDetailss['fixtures']['played']['away'],
                  All:TeamDetailss['fixtures']['played']['total']),

              CardOfTeamDetails(
                  type: "Wins",
                  Home: TeamDetailss['fixtures']['wins']['home'],
                  Away: TeamDetailss['fixtures']['wins']['away'],
                  All:TeamDetailss['fixtures']['wins']['total']),
              CardOfTeamDetails(
                  type: "Draws",
                  Home: TeamDetailss['fixtures']['draws']['home'],
                  Away: TeamDetailss['fixtures']['draws']['away'],
                  All:TeamDetailss['fixtures']['draws']['total']),
              CardOfTeamDetails(
                  type: "Loses",
                  Home: TeamDetailss['fixtures']['loses']['home'],
                  Away: TeamDetailss['fixtures']['loses']['away'],
                  All:TeamDetailss['fixtures']['loses']['total']),
              Container(
                alignment: Alignment.centerLeft,
                color: Color.fromRGBO(235, 235, 235, 1),
                height: 60,
                width: double.infinity,
                child: Text("    GOALS",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25),)
              ),
              CardOfTeamDetails(
                  type: "Goals For",
                  Home: TeamDetailss['goals']['for']['total']['home'],
                  Away: TeamDetailss['goals']['for']['total']['away'],
                  All:TeamDetailss['goals']['for']['total']['total']),
              CardOfTeamDetails(
                  type: "Goals Against",
                  Home: TeamDetailss['goals']['against']['total']['home'],
                  Away: TeamDetailss['goals']['against']['total']['away'],
                  All:TeamDetailss['goals']['against']['total']['total']),
              Container(
                  alignment: Alignment.centerLeft,
                  color: Color.fromRGBO(235, 235, 235, 1),
                  height: 60,
                  width: double.infinity,
                  child: Text("    GOALS Average",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25),)
              ),
              CardOfTeamDetails(
                  type: "Goals For",
                  Home:num.parse( TeamDetailss['goals']['for']['average']['home']),
                  Away: num.parse(TeamDetailss['goals']['for']['average']['away']),
                  All:num.parse(TeamDetailss['goals']['for']['average']['total'])),
              CardOfTeamDetails(
                  type: "Goals Against",
                  Home: num.parse(TeamDetailss['goals']['against']['average']['home']),
                  Away: num.parse(TeamDetailss['goals']['against']['average']['away']),
                  All:num.parse(TeamDetailss['goals']['against']['average']['total'])),
              Container(
                  alignment: Alignment.centerLeft,
                  color: Color.fromRGBO(235, 235, 235, 1),
                  height: 60,
                  width: double.infinity,
                  child: Text("    Clean Sheet",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25),)
              ),
              CardOfTeamDetails(
                  type: "Clean Sheet",
                  Home: TeamDetailss['clean_sheet']['home'],
                  Away: TeamDetailss['clean_sheet']['away'],
                  All:TeamDetailss['clean_sheet']['total']),
            ]),

          )
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
