

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';
import 'package:sports_news/Screens/Match_Details_Screen.dart';

class CardOfMatch extends StatelessWidget {

  final item;

  const CardOfMatch(this.item);

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: EdgeInsets.only(top: 7, bottom: 7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 10,
      child: Column(
        children: [
          SizedBox(height: 4,),
          item['fixture']['status']['long'] == 'Match Finished'
              ? Text(
            'Match Finished',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
              : ((item['fixture']['status']['long'] == 'Not Started')
              ? Text('Time : ${item['fixture']['date'].toString().substring(
              11, 16)} UTC', style: TextStyle(fontWeight: FontWeight.bold))
              : Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(7),
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red)),
                    Text(
                      "Live",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.red),
                    ),
                  ],
                ),
                Text('${item['fixture']['status']['elapsed']}" ',
                  style: TextStyle(fontSize: 18, color: Colors.green),),
              ],
            ),
          )),


          Container(
            height: 70,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints)=>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width:constraints.maxWidth*0.15,
                    child: ClipRRect(
                      child: Image.network(
                        '${item['teams']['home']['logo']}',


                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2),
                    width: constraints.maxWidth*0.25,
                    child: Text(

                      '${item['teams']['home']['name']}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 35,
                    width:  constraints.maxWidth*0.20,

                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2),
                      color: Colors.white54,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        item['goals']['home'] == null ? Text("--") : Text(
                          "${item['goals']['home'].toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        item['goals']['away'] == null ? Text("--") : Text(
                          "${item['goals']['away'].toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 2),
                    width:  constraints.maxWidth*0.25,
                    child: Text(

                      '${item['teams']['away']['name']}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    width:constraints.maxWidth*0.15,
                    child: ClipRRect(
                      child: Image.network(
                        '${item['teams']['away']['logo']}',

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),



          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Builder(
                builder: (ctx)=>InkWell(
                  child: Row(
                    children: [
                      Text(
                        "More Details",
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return MatchDetails(idHome:  item['teams']['home']['id'],
                          idAway: item['teams']['away']['id'],
                          nameHome: item['teams']['home']['name'],
                          nameAway: item['teams']['away']['name'],
                          logoHome: item['teams']['home']['logo'],
                          logoAway: item['teams']['away']['logo'],
                          goalsHome: item['goals']['home'],
                          goalsAway: item['goals']['away'],
                          FixturesId: item['fixture']['id'],
                          staduim: item['fixture']['venue']['name'],
                          date: item['fixture']['date']);
                    }));

                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
