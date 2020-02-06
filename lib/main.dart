import 'package:flutter/material.dart';
import 'package:weather_app/views/spalsh_screen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: LoadingView());
}
