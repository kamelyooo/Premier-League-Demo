import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';
import 'package:sports_news/widgets/CardOfTop10.dart';

import '../main.dart';

class Container3 extends StatelessWidget {
  static const con3="con3";
  @override
  Widget build(BuildContext context) {

    final apiProvidtrue=Provider.of<ApiProvider>(context);
    final apiProvidflase=Provider.of<ApiProvider>(context,listen: false);
    nav() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MyApp();
      }));
    }
    if (apiProvidtrue.isloadingTopScore) {
      apiProvidflase
          .TopScoresData()
          .then((_) => apiProvidflase
              .isloadingTopScore = false).catchError((e) {
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
      child:apiProvidflase
          .isloadingTopScore?Container(
        height: MediaQuery.of(context).size.height/2,
        child: SpinKitCubeGrid (
          duration: Duration(milliseconds: 900),
          color: Color.fromRGBO(55, 0, 60, 1.0),
          size: 120,
        ),
      ):ListView(
        children: [

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 10,top: 10),
            child: Text("Top 10 Statistics",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.white),),
          ),
          SizedBox(height: 10,),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 2,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (ctx,index){

            return CardOfTop10(index: index,ctx: ctx,);
          },itemCount: 10,)
        ],
      )
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
