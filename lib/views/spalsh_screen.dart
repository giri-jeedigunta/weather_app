import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/weather_helper.dart';
import 'package:weather_app/views/weather.dart';
import 'package:weather_app/weather_store.dart';

class LoadingView extends StatefulWidget {
  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  WeatherService weather = WeatherService();
  WeatherStore weatherStore;

  void getWeather() async {
    await weatherStore.updateCoordinates();

    final todaysWeather = await weather.getLocationWeather(
        weatherStore.latitude, weatherStore.longitude);
    final fiveDayWeatherForecast = await weather.getFiveDayForecast(
        weatherStore.latitude, weatherStore.longitude);

    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WeatherView(
                todaysWeather: todaysWeather,
                fiveDayWeatherForecast: fiveDayWeatherForecast,
              )),
    );
  }

  @override
  void initState() {
    super.initState();

    weatherStore = Provider.of<WeatherStore>(this.context, listen: false);
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
