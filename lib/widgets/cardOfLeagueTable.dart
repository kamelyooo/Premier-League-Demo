

import 'package:flutter/material.dart';
import 'package:sports_news/Screens/TeamDetails_Screen.dart';

class cardOfLeagueTable extends StatelessWidget {
  final item;

  cardOfLeagueTable({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return TeamDetails(teamId: item['team']['id'],teamlogo: item['team']['logo'],teamName:item['team']['name'] ,);
          }));
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints)=>Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20),
                  width:constraints.maxWidth*0.10,child: Text(item['rank'].toString())),
              Container(

                  height: 12,
                  width:constraints.maxWidth*0.10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(235, 235, 235, 1),
                  )),
              Container(

                  width:constraints.maxWidth*0.10,
                  alignment: Alignment.centerLeft,
                  child: Image.network(item['team']['logo'])),
              Container(
                  width:constraints.maxWidth*0.30,
                  child: Text(
                    item['team']['name'],
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                  )),
              Container(alignment:Alignment.centerLeft,width:constraints.maxWidth*0.15,child: Text('${item['all']['played']}')),
              Container(alignment:Alignment.centerLeft,width:constraints.maxWidth*0.15,child: Text('${item['goalsDiff']}')),
              Container(width:constraints.maxWidth*0.10,child: Text('${item['points']}')),
            ],
          ),
        ),
      ),
    );
  }
}
