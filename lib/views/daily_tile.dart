import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyTile extends StatelessWidget {
  final int? dt, min, max;
  final String? icon, main;
  const DailyTile({Key? key, this.dt, this.min, this.max, this.main, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var date, formattedDate, finalDate;
    final now = DateTime.now();

    date = DateTime.fromMillisecondsSinceEpoch(dt! * 1000);
    formattedDate = DateFormat('EEE').format(date);

    if(formattedDate == DateFormat('EEE').format(now)) {
      finalDate = "Today";
    }
    else if(formattedDate == DateFormat('EEE').format(DateTime(now.year, now.month, now.day + 1))) {
      finalDate = "Tomorrow";
    }
    else {
      finalDate = DateFormat('EEE').format(date);
    }

    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.network(icon!),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(finalDate,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 5),
              Text(main!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Spacer(),
          Text("$max° / $min°",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}