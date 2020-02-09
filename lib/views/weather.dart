import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/weather_helper.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/components/todays_forecast.dart';
import 'package:weather_app/components/week_day_forecast.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/weather_store.dart';

class WeatherView extends StatefulWidget {
  WeatherView({this.todaysWeather, this.fiveDayWeatherForecast});
  final Map todaysWeather;
  final Map fiveDayWeatherForecast;

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherService weather = WeatherService();
  final String formattedDate = DateFormat.yMMMd().format(DateTime.now());
  final String formattedTime = DateFormat.jm().format(DateTime.now());

  Map updatedWeather, updatedForecast;

  @override
  void initState() {
    super.initState();

    updateWeather(widget.todaysWeather, widget.fiveDayWeatherForecast);
  }

  void updateWeather(dynamic todaysWeather, dynamic fiveDayWeatherForecast) {
    setState(() {
      updatedWeather = todaysWeather;
      updatedForecast = fiveDayWeatherForecast;
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherStore = Provider.of<WeatherStore>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: const Color(0xff6ABDCB),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                //flex: 8,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 28,
                      ),
                      Icon(
                        updatedWeather['weatherIcon'],
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 26,
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
                        child: Text(
                          (updatedWeather['city'] +
                                  ', ' +
                                  updatedWeather['country'])
                              .toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 28,
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
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              updatedWeather['now'].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Gelasio',
                                fontSize: 96,
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
                            ),
                          ),
                          Icon(
                            WeatherIcons.celsius,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Text(
                          toBeginningOfSentenceCase(
                              updatedWeather['description']),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 14,
                            color: Colors.white,
                            letterSpacing: 1.25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 250,
                        child: Divider(
                          color: Colors.teal.shade100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'Low: ' +
                              updatedWeather['low'].toString() +
                              '°C |  High: ' +
                              updatedWeather['high'].toString() +
                              '°C',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Lora',
                            fontSize: 12,
                            color: Colors.white,
                            letterSpacing: 1.35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            updatedForecast['todaysForecast']['timeSlots']
                                .length,
                            (index) => index < 7
                                ? TodaysForecast(
                                    timeStamp: updatedForecast['todaysForecast']
                                        ['timeSlots'][index],
                                    temprature:
                                        (updatedForecast['weeklyForecast']
                                                ['tempraturesList'][0][index])
                                            .toInt(),
                                    endOfList: index > 5 ||
                                            index ==
                                                updatedForecast['todaysForecast']
                                                            ['timeSlots']
                                                        .length -
                                                    1
                                        ? const Color(0xff6ABDCB)
                                        : Colors.white24,
                                  )
                                : const SizedBox(width: 0, height: 0),
                          ),
                        ),
                        padding: const EdgeInsets.all(0),
                      ),
                    ],
                  ),
                  color: const Color(0xff6ABDCB),
                  width: double.infinity,
                ),
              ),
              Container(
                //flex: 1,
                child: Container(
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
              ),
              Container(
                //flex: 7,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 28,
                      ),
                      Column(
                        children: List.generate(
                          updatedForecast['weeklyForecast']['dateList'].length,
                          (index) => index != 0
                              ? WeekDayForecast(
                                  weekDayName: DateFormat('EEEE').format(
                                      DateTime.parse(
                                          updatedForecast['weeklyForecast']
                                                  ['dateList'][index]
                                              .toString())),
                                  weekTempratureDayLowHigh:
                                      updatedForecast['weeklyForecast']
                                          ['tempraturesList'][index]
                                        ..sort(),
                                  weatherConditionIcon: weather.getWeatherIcon(
                                      updatedForecast['weeklyForecast']
                                          ['conditionList'][index]),
                                )
                              : const SizedBox(width: 0, height: 0),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black26,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                        ),
                        child: Observer(
                          builder: (_) => RawMaterialButton(
                            onPressed: () async {
                              await weatherStore.updateCoordinates();

                              final todaysWeather =
                                  await weather.getLocationWeather(
                                      weatherStore.latitude,
                                      weatherStore.longitude);
                              final fiveDayWeatherForecast =
                                  await weather.getFiveDayForecast(
                                      weatherStore.latitude,
                                      weatherStore.longitude);

                              updateWeather(
                                  todaysWeather, fiveDayWeatherForecast);
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
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
