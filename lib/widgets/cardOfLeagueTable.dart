

import 'package:flutter/material.dart';
import 'package:sports_news/Screens/TeamDetails_Screen.dart';

class cardOfLeagueTable extends StatelessWidget {
  final item;

  cardOfLeagueTable({this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.only(left: 30, right: 10),
      color: Colors.white,
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return TeamDetails(teamId: item['team']['id'],teamlogo: item['team']['logo'],teamName:item['team']['name'] ,);
          }));
        },
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(item['rank'].toString()),
                  Expanded(
                    child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(235, 235, 235, 1),
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 2),
                    width: 50,
                      alignment: Alignment.centerLeft,
                      child: Image.network(item['team']['logo'])),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Container(
                        width: 75,
                        child: Text(
                          item['team']['name'],
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.start,
                        )),
                  ),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(left: 17),
                          child: Text('${item['all']['played']}'))),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${item['goalsDiff']}'),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('${item['points']}'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
