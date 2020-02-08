import 'package:flutter/material.dart';

class TodaysForecast extends StatelessWidget {
  const TodaysForecast({this.temprature, this.timeStamp, this.endOfList});

  final int temprature;
  final String timeStamp;
  final Color endOfList;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        height: 55,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1,
              color: endOfList,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            Text(
              '$timeStamp',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 10,
                color: Colors.white,
                letterSpacing: 1.15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              '$temprature°C',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 12,
                color: Colors.white,
                letterSpacing: 1.25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
