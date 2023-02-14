import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class HourlyTile extends StatelessWidget {
  final int? dt, temp;
  final String? main, timezone;
  const HourlyTile({Key? key, this.dt, this.temp, this.main, this.timezone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var location, dateTime, formattedDateTime, finalDateTime;
    tz.initializeTimeZones();
    location = tz.getLocation(timezone!);
    dateTime = tz.TZDateTime.fromMillisecondsSinceEpoch(location, dt! * 1000);

    formattedDateTime = DateFormat('HH:00').format(dateTime);

    if (formattedDateTime == '00:00') {
      finalDateTime = DateFormat('MM/dd').format(dateTime);
    } else {
      finalDateTime = DateFormat('HH:00').format(dateTime);
    }

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            finalDateTime,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "$temp°",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            main!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
