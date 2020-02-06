import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/utils/weather_helper.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/components/todays_forecast.dart';
import 'package:weather_app/components/week_day_forecast.dart';

class WeatherView extends StatefulWidget {
  WeatherView({this.todaysWeather, this.fiveDayWeatherForecast});
  final todaysWeather;
  final fiveDayWeatherForecast;

  @override
  _WeatherViewState createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherHelper weather = WeatherHelper();
  final formattedDate = new DateFormat.yMMMd().format(new DateTime.now());
  final formattedTime = new DateFormat.jm().format(new DateTime.now());

  int currentTemprature, todayLow, todayHigh;
  List todayTimeSlots = [];

  String city, country, description;

  List fiveDayForecastDates,
      fiveDayForecastTempratures,
      fiveDayForecastWeatherCondition = [];

  IconData iconName;
  Map<String, dynamic> fiveDaysForecastFormatted = {};

  @override
  void initState() {
    super.initState();

    updateWeather(widget.todaysWeather, widget.fiveDayWeatherForecast);
  }

  void formatFiveDayForecast(data) {
    todayTimeSlots = [];
    for (var i = 0; i < data.length; i++) {
      var dateText = data[i]['dt_txt'].split(' ');
      String dateKey = dateText[0];
      String timeStamp = dateText[1];

      //Today:
      List minMax = [data[i]['main']['temp_min'], data[i]['main']['temp_max']];
      int condition = data[i]['weather'][0]['id'];

      // Today Time Slots:
      if (dateText[0] == data[0]['dt_txt'].split(' ')[0]) {
        int tempTime = int.parse(timeStamp.split(':')[0]);
        int pmTime = tempTime > 12 ? tempTime - 12 : tempTime;
        todayTimeSlots.add(tempTime > 11 ? '$pmTime PM' : '$tempTime AM');
      }

      // Five Day Forecast Data:
      (fiveDaysForecastFormatted.containsKey(dateKey))
          ? fiveDaysForecastFormatted.update(dateKey, (value) => value + minMax)
          : () {
              fiveDaysForecastFormatted.putIfAbsent(dateKey, () => minMax);
              fiveDayForecastWeatherCondition.add(condition);
            }();
    }

    // Five Day Forecast Data:
    fiveDayForecastDates = fiveDaysForecastFormatted.keys.toList();
    fiveDayForecastTempratures = fiveDaysForecastFormatted.values.toList();
    fiveDayForecastWeatherCondition.toList();
  }

  void updateWeather(dynamic data, dynamic fiveDayWeatherForecast) {
    setState(() {
      int condition = data['weather'][0]['id'];

      city = data['name'];
      country = data['sys']['country'];
      description = data['weather'][0]['description'];

      //Today:
      currentTemprature = (data['main']['temp']).toInt();
      iconName = weather.getWeatherIcon(condition);
      todayLow = (data['main']['temp_min']).toInt();
      todayHigh = (data['main']['temp_max']).toInt();

      // Five day forecast:
      formatFiveDayForecast(fiveDayWeatherForecast['list']);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xff6ABDCB),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 28.0,
                    ),
                    Icon(
                      iconName,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    SizedBox(
                      height: 26.0,
                    ),
                    Text(
                      '$formattedDate - $formattedTime'
                          .toString()
                          .toUpperCase(),
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
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
                            '$currentTemprature',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Gelasio',
                              fontSize: 96.0,
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
                        'Low: $todayLow  |  High: $todayHigh°C',
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
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          todayTimeSlots.length,
                          (index) {
                            return index < 7
                                ? TodaysForecast(
                                    timeStamp: todayTimeSlots[index],
                                    temprature: fiveDayForecastTempratures[0]
                                            [index]
                                        .toInt(),
                                    endOfList: index > 5 ||
                                            index == todayTimeSlots.length - 1
                                        ? Color(0xff6ABDCB)
                                        : Colors.white24,
                                  )
                                : SizedBox(width: 0, height: 0);
                          },
                        ),
                      ),
                      padding: const EdgeInsets.all(0.0),
                    ),
                  ],
                ),
                color: Color(0xff6ABDCB),
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 0),
                width: double.infinity,
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Color(0xff6ABDCB),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 28.0,
                    ),
                    Column(
                      children: List.generate(
                        fiveDayForecastDates.length,
                        (index) {
                          return index != 0
                              ? WeekDayForecast(
                                  weekDayName: DateFormat('EEEE').format(
                                      DateTime.parse(fiveDayForecastDates[index]
                                          .toString())),
                                  weekTempratureDayLowHigh:
                                      fiveDayForecastTempratures[index]..sort(),
                                  weatherConditionIcon: weather.getWeatherIcon(
                                      fiveDayForecastWeatherCondition[index]),
                                )
                              : SizedBox(width: 0, height: 0);
                        },
                      ),
                    ),
                    Container(
                      width: 40.0,
                      height: 40.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black26,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: RawMaterialButton(
                        onPressed: () async {
                          var todaysWeather =
                              await weather.getLocationWeather();
                          var fiveDayWeatherForecast =
                              await weather.getLocationForecast();

                          updateWeather(todaysWeather, fiveDayWeatherForecast);
                        },
                        child: Icon(
                          Icons.near_me,
                          color: Colors.black87,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
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
