import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather_helper.dart';
import 'package:weather_app/views/city_search.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/components/todays_forecast.dart';
import 'package:weather_app/components/week_day_forecast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_store.dart';

class WeatherView extends StatefulWidget {
  static String routeName = 'WeatherView';

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherService weather = WeatherService();
  WeatherStore weatherStore;
  final String formattedDate = DateFormat.yMMMd().format(DateTime.now());
  final String formattedTime = DateFormat.jm().format(DateTime.now());

  String cityAndCountry = '';

  @override
  void initState() {
    super.initState();

    weatherStore = Provider.of<WeatherStore>(context, listen: false);
    addEllipses(
      weatherStore.todaysWeather['city'].toString(),
      weatherStore.todaysWeather['country'].toString(),
    );
  }

  void addEllipses(String city, String country) {
    if (city.length < 16) {
      cityAndCountry = '$city, $country';
    } else if (city.length > 15 && city.length <= 19) {
      cityAndCountry = '$city';
    } else if (city.length > 19) {
      cityAndCountry = '${city.substring(0, 15)}...';
    }
    //cityAndCountry
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xff6ABDCB),
        body: OrientationBuilder(
          builder: (context, orientation) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Icon(
                        weatherStore.todaysWeather['weatherIcon'],
                        color: Colors.white,
                        size: 36,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Text(
                        '$formattedDate - $formattedTime'
                            .toString()
                            .toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Lora',
                          fontSize: 12,
                          color: Colors.white,
                          letterSpacing: 1.25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Observer(
                          builder: (_) => Container(
                            child: TextFormField(
                              initialValue: cityAndCountry.toUpperCase(),
                              readOnly: true,
                              textAlign: TextAlign.center,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CitySearch.routeName);
                              },
                              style: TextStyle(
                                fontFamily: 'Lora',
                                fontSize: 24,
                                color: Colors.white,
                                letterSpacing: 1.25,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                      // bottomLeft
                                      offset: const Offset(1.25, 1.25),
                                      color: Colors.black12,
                                      blurRadius: 5),
                                ],
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: null,
                                labelText: null,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Observer(
                                builder: (_) => Text(
                                      weatherStore.todaysWeather['now']
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Gelasio',
                                        fontSize: 86,
                                        color: Colors.white,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600,
                                        shadows: [
                                          Shadow(
                                              // bottomLeft
                                              offset: const Offset(1.25, 1.25),
                                              color: Colors.black26,
                                              blurRadius: 5),
                                        ],
                                      ),
                                    )),
                          ),
                          Icon(
                            WeatherIcons.celsius,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Observer(
                            builder: (_) => Text(
                                  toBeginningOfSentenceCase(weatherStore
                                      .todaysWeather['description']),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Lora',
                                    fontSize: 14,
                                    color: Colors.white,
                                    letterSpacing: 1.25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 20,
                          width: 250,
                          child: Divider(
                            color: Colors.teal.shade100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Observer(
                            builder: (_) => Text(
                                  'Low: ${weatherStore.todaysWeather['low']} °C |  High: ${weatherStore.todaysWeather['high']} °C'
                                      .toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Lora',
                                    fontSize: 12,
                                    color: Colors.white,
                                    letterSpacing: 1.35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        child: Observer(
                            builder: (_) => Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    weatherStore
                                        .fiveDayWeatherForecast[
                                            'todaysForecast']['timeSlots']
                                        .length,
                                    (index) => index < 7
                                        ? TodaysForecast(
                                            timeStamp: weatherStore
                                                        .fiveDayWeatherForecast[
                                                    'todaysForecast']
                                                ['timeSlots'][index],
                                            temprature: (weatherStore
                                                            .fiveDayWeatherForecast[
                                                        'weeklyForecast'][
                                                    'tempraturesList'][0][index])
                                                .toInt(),
                                            endOfList: index > 5 ||
                                                    index ==
                                                        weatherStore
                                                                .fiveDayWeatherForecast[
                                                                    'todaysForecast']
                                                                    [
                                                                    'timeSlots']
                                                                .length -
                                                            1
                                                ? const Color(0xff6ABDCB)
                                                : Colors.white24,
                                          )
                                        : const SizedBox(width: 0, height: 0),
                                  ),
                                )),
                        padding: const EdgeInsets.all(0),
                      ),
                    ],
                  ),
                  color: const Color(0xff6ABDCB),
                  width: double.infinity,
                ),
              ),
              (orientation != Orientation.landscape)
                  ? Container(
                      child: Container(
                        height: 45,
                        margin: const EdgeInsets.only(top: 0),
                        width: double.infinity,
                        color: Colors.white,
                        child: Container(
                          width: double.infinity,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Color(0xff6ABDCB),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(45),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 1,
                    ),
              (orientation != Orientation.landscape)
                  ? Expanded(
                      flex: 3,
                      child: Observer(
                          builder: (_) => Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: ListView(
                                  children: <Widget>[
                                    Column(
                                      children: List.generate(
                                        weatherStore
                                            .fiveDayWeatherForecast[
                                                'weeklyForecast']['dateList']
                                            .length,
                                        (index) => index != 0
                                            ? WeekDayForecast(
                                                weekDayName: DateFormat('EEEE')
                                                    .format(DateTime.parse(
                                                        weatherStore
                                                            .fiveDayWeatherForecast[
                                                                'weeklyForecast']
                                                                ['dateList']
                                                                [index]
                                                            .toString())),
                                                weekTempratureDayLowHigh:
                                                    weatherStore.fiveDayWeatherForecast[
                                                                'weeklyForecast']
                                                            ['tempraturesList']
                                                        [index]
                                                      ..sort(),
                                                weatherConditionIcon: weather
                                                    .getWeatherIcon(weatherStore
                                                                .fiveDayWeatherForecast[
                                                            'weeklyForecast'][
                                                        'conditionList'][index]),
                                                weekDayCount: index.toInt(),
                                              )
                                            : const SizedBox(
                                                width: 0, height: 0),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Observer(
                                        builder: (_) => RawMaterialButton(
                                          constraints: const BoxConstraints(
                                              maxWidth: 40),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            side: BorderSide(
                                                color: Colors.black38),
                                          ),
                                          padding: const EdgeInsets.all(5),
                                          onPressed: () async {
                                            await weatherStore.updateLocation();
                                            await weatherStore
                                                .updateWeatherAndForecast(
                                                    weatherStore.latitude,
                                                    weatherStore.longitude);
                                          },
                                          child: Icon(
                                            Icons.refresh,
                                            color: Colors.black87,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(45),
                                  ),
                                ),
                              )),
                    )
                  : const SizedBox(
                      height: 1,
                    ),
            ],
          ),
        ),
      );
}
