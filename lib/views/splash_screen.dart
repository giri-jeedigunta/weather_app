import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/weather.dart';
import 'package:weather_app/weather_store.dart';

class LoadingView extends StatefulWidget {
  static String routeName = 'LoadingView';

  @override
  _LoadingViewState createState() => _LoadingViewState();
}

class _LoadingViewState extends State<LoadingView> {
  WeatherStore weatherStore;

  // ignore: avoid_void_async
  void getWeather() async {
    await weatherStore.updateLocation();
    await weatherStore.updateWeatherAndForecast(
        weatherStore.latitude, weatherStore.longitude);

    await Navigator.pushNamed(
      context,
      WeatherView.routeName
    );
  }

  @override
  void initState() {
    super.initState();

    weatherStore = Provider.of<WeatherStore>(context, listen: false);
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
          ),
        ),
      );
}
