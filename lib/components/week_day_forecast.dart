import 'package:flutter/material.dart';

class WeekDayForecast extends StatelessWidget {
  WeekDayForecast({this.weekDayName, this.weekTempratureDayLowHigh, this.weatherConditionIcon});

  final weekDayName;
  final List weekTempratureDayLowHigh;
  final weatherConditionIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(0, 0, 0, 12.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 11.5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            child: Text(
              '$weekDayName',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 14.0,
                color: Colors.black87,
                letterSpacing: 1.35,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Icon(
              weatherConditionIcon,
              color: Colors.black87,
              size: 16.0,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              '${weekTempratureDayLowHigh[0].toInt()}° | ${weekTempratureDayLowHigh[weekTempratureDayLowHigh.length - 1].toInt()}°',
              style: TextStyle(
                fontFamily: 'Gelasio',
                fontSize: 14.0,
                color: Colors.black87,
                letterSpacing: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
