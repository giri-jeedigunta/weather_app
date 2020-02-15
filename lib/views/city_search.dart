import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/views/weather.dart';
import 'package:weather_app/weather_store.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/services/api_helper.dart';

class CitySearch extends StatefulWidget {
  static String routeName = 'CitySearchView';
  @override
  _CitySearchState createState() => _CitySearchState();
}

class _CitySearchState extends State<CitySearch> {
  WeatherStore weatherStore;

  @override
  void initState() {
    super.initState();

    weatherStore = Provider.of<WeatherStore>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 70, 5, 0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: const Alignment(
                      0.5,
                      0.5,
                    ),
                    colors: const [
                      Color(0xff6ABDCB),
                      Color(0xFFFFFFFF),
                    ], // whitish to gray
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const Text('Search by city name. Example: London'),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Observer(
                        builder: (_) => Container(
                          child: TextFormField(
                            autofocus: false,
                            readOnly: false,
                            enabled: true,
                            initialValue:
                                weatherStore.todaysWeather['city'].toString(),
                            onFieldSubmitted: (value) async {
                              final apiHelper = ApiHelperService(
                                  '$kWeatherApiUrl?q=$value&appid=$kWeatherAppId&units=metric');

                              final weatherData = await apiHelper.getResponse();
                              if (weatherData == null) {
                                return;
                              }

                              await weatherStore.updateWeatherAndForecast(
                                  weatherData['coord']['lat'],
                                  weatherData['coord']['lon']);

                              print(weatherData);

                              await Navigator.pushNamed(
                                  context, WeatherView.routeName);
                            },
                            validator: (String value) => value.isEmpty
                                ? 'Error: Enter a valid city name'
                                : null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Enter City Name',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
