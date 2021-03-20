import 'package:flutter/material.dart';

class CardOfTeamDetails extends StatelessWidget {
  final type;
  final Home;
  final Away;
  final All;

  CardOfTeamDetails({
   @required this.type,
    @required  this.Home,
    @required this.Away,
    @required this.All,
  });



  @override
  Widget build(BuildContext context) {


   Color colorHome(){
  if (Home > Away) {
  return  Colors.cyan;
  } else if (Home < Away) {
  return Colors.red;
  } else {
  return Colors.green;
  }
  }
   Color colorAway(){
     if (Home < Away) {
       return  Colors.cyan;
     } else if (Home > Away) {
       return Colors.red;
     } else {
       return Colors.green;
     }
   }

    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left:9),
              child: Text(
                "${type}",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
              child: Text(
            "${Home}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: colorHome()),
          )),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Text(
            "${Away}",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color:colorAway()),
          )),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(
              "${All}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ],
      ),
    );
  }
}
