import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_news/Providers/Api_Provider.dart';

class CardOfTop10 extends StatelessWidget {
  final int index;
  final BuildContext ctx;

  const CardOfTop10({this.index, this.ctx});

  @override
  Widget build(BuildContext context) {
    final apiProvidtrue = Provider.of<ApiProvider>(context);
    final apiProvidctx = Provider.of<ApiProvider>(ctx);
    return Card(
      color: Color.fromRGBO(71, 5, 77, 1),
      child: Column(
        children: [
          Row(
            children: [
              //photo
              Container(
                  margin: EdgeInsets.all(12),
                  height: 85,
                  width: 85,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                          apiProvidctx.TopScorse[index]['player']['photo']))),
              Column(
                children: [
                  Text(
                    '# ${index + 1}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    child: Image.network(apiProvidtrue.TopScorse[index]
                        ['statistics'][0]['team']['logo']),
                  )
                ],
              )
            ],
          ),
          Expanded(
            child: Container(

              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(48, 1, 53, 1),
                  borderRadius: BorderRadius.circular(5)),
              margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${apiProvidctx.TopScorse[index]['statistics'][0]['goals']['total']}',
                    style: TextStyle(
                        color: Color.fromRGBO(245, 44, 130, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "goals",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
