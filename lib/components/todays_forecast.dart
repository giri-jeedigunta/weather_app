import 'package:flutter/material.dart';

class TodaysForecast extends StatelessWidget {
  const TodaysForecast({this.temprature, this.timeStamp, this.endOfList});

  final temprature, timeStamp, endOfList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
      height: 55.0,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1.0,
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
              fontSize: 10.0,
              color: Colors.white,
              letterSpacing: 1.15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            '$temprature°C',
            style: TextStyle(
              fontFamily: 'Lora',
              fontSize: 12.0,
              color: Colors.white,
              letterSpacing: 1.25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
