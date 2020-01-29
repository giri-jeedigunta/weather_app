import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/weather_helper.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherView extends StatefulWidget {
  WeatherView({this.weatherInfo});
  final weatherInfo;

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherHelper weather = WeatherHelper();
  final formattedDate = new DateFormat.yMMMd().format(new DateTime.now());
  int temprature;
  String city;
  String country;
  String description;
  int low;
  int high;
  IconData iconName;

  @override
  void initState() {
    super.initState();

    refreshWeather(widget.weatherInfo);
  }

  void refreshWeather(dynamic data) {
    temprature = (data['main']['temp']).toInt();
    city = data['name'];
    country = data['sys']['country'];
    int condition = data['weather'][0]['id'];
    description = data['weather'][0]['description'];
    iconName = weather.getWeatherIcon(condition);
    low = (data['main']['temp_min']).toInt();
    high = (data['main']['temp_max']).toInt();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 22.0,
                    ),                    
                    Icon(
                      iconName,
                      color: Colors.white,
                      size: 38.0,
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    Text(
                      '$formattedDate'.toString().toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Lora',
                        fontSize: 12.0,
                        color: Colors.white,
                        letterSpacing: 1.25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45.0),
                      child: Text(
                        '$city, $country'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lora',
                          fontSize: 28.0,
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                // bottomLeft
                                offset: Offset(1.25, 1.25),
                                color: Colors.black12,
                                blurRadius: 5.0),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            '$temprature',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Gelasio',
                              fontSize: 90.0,
                              color: Colors.white,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                    // bottomLeft
                                    offset: Offset(1.25, 1.25),
                                    color: Colors.black26,
                                    blurRadius: 5.0),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          WeatherIcons.celsius,
                          color: Colors.white,
                          size: 25.0,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Text(
                        toBeginningOfSentenceCase('$description'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lora',
                          fontSize: 14.0,
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                      width: 250.0,
                      child: Divider(
                        color: Colors.teal.shade100,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: Text(
                        'Low: $low °C | High: $high °C', 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lora',
                          fontSize: 12.0,
                          color: Colors.white,
                          letterSpacing: 1.35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                color: Colors.lightBlueAccent,
                width: double.infinity,
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                      ),
                    ),
                  ),
                )),
            Expanded(
              flex: 8,
              child: Container(
                child: Text(''),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(45),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
