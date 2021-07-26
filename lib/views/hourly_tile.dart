import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyTile extends StatelessWidget {
  final dt, temp, icon, main;
  const HourlyTile({Key key, this.dt, this.temp, this.icon, this.main}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var dateTime, formattedDateTime, finalDateTime;

    dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    formattedDateTime = DateFormat('HH:00').format(dateTime);

    if(formattedDateTime == '00:00'){
      finalDateTime = DateFormat('MM/dd').format(dateTime);
    } else {
      finalDateTime = DateFormat('HH:00').format(dateTime);
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(finalDateTime,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 5),
          Text(temp.toString() + "°",
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(2),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.network(icon),
          ),
          SizedBox(height: 5),
          Text(main.toString(),
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}