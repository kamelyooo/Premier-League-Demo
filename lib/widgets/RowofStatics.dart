import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';

class RowOfStatics extends StatelessWidget {
  final int type;

  RowOfStatics({@required this.type});

  @override
  Widget build(BuildContext context) {
    final apiProvidtrue = Provider.of<ApiProvider>(context);
    return Container(
      height: 35,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          apiProvidtrue.StatisticsHome[0]['statistics'][type]['value'] == null
              ? Text('--',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
              : Text(
                  '${apiProvidtrue.StatisticsHome[0]['statistics'][type]['value']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
          Text(
            '${apiProvidtrue.StatisticsHome[0]['statistics'][type]['type']}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          apiProvidtrue.StatisticsAway[0]['statistics'][type]['value'] == null
              ? Text('--',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
              : Text(
                  '${apiProvidtrue.StatisticsAway[0]['statistics'][type]['value']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
