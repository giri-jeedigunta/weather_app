import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weather_app/views/spalsh_screen.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_store.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Provider<WeatherStore>(
        create: (_) => WeatherStore(),
        child: Observer(
          builder: (_) => MaterialApp(
            home: LoadingView(),
          ),
        ),
      );
}
