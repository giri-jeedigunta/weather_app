import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_helper.dart';
import 'package:weather_app/views/weather.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  WeatherHelper weather = WeatherHelper();

  void getWeather() async {
    var todaysWeather = await weather.getLocationWeather();
    var fiveDayWeatherForecast = await weather.getLocationForecast();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return WeatherView(
            todaysWeather: todaysWeather,
            fiveDayWeatherForecast: fiveDayWeatherForecast);
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Image.asset('assets/images/loader.gif')],
        )),
      );
}
