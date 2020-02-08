import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/services/api_helper.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherService {
  Map<dynamic, dynamic> _todaysWeatherJSON = {};
  Map<dynamic, dynamic> _fiveDaysForecastJSON = {};

  Future<dynamic> getLocationWeather(double lat, double long) async {
    final apiHelper = ApiHelperService(
        '$kWeatherApiUrl?lat=$lat&lon=$long&appid=$kWeatherAppId&units=metric');

    // Using var as the data is dynamic:
    final weatherData = await apiHelper.getResponse();
    formatTodaysWeather(weatherData);

    return _todaysWeatherJSON;
  }

  Future<dynamic> getFiveDayForecast(double lat, double long) async {
    // GET weather info of the location:
    final apiHelper = ApiHelperService(
        '$kForecastApiUrl?lat=$lat&lon=$long&appid=$kWeatherAppId&units=metric');

    // Using var as the data is dynamic:
    final forecastData = await apiHelper.getResponse();
    formatFiveDayForecast(forecastData['list']);

    return _fiveDaysForecastJSON;
  }

  void formatTodaysWeather(Map todaysWeatherInfo) {
    _todaysWeatherJSON = {
      'now': todaysWeatherInfo['main']['temp'].toInt(),
      'low': todaysWeatherInfo['main']['temp_min'].toInt(),
      'high': todaysWeatherInfo['main']['temp_max'].toInt(),
      'description': todaysWeatherInfo['weather'][0]['description'],
      'city': todaysWeatherInfo['name'],
      'country': todaysWeatherInfo['sys']['country'],
      'condition': todaysWeatherInfo['weather'][0]['id'].toInt(),
      'weatherIcon': getWeatherIcon(todaysWeatherInfo['weather'][0]['id'])
    };
  }

  void formatFiveDayForecast(List fiveDayForecastInfo) {
    final todayTimeSlots = [];
    List todayMinMax;
    String dtTxtDate, dtTxtTime;
    int condition;
    List fiveDayForecastDates, fiveDayForecastTempratures;
    final fiveDayForecastWeatherCondition = [];
    final fiveDaysForecastFormatted = {};
    _fiveDaysForecastJSON = {};

    for (var i = 0; i < fiveDayForecastInfo.length; i++) {
      final dtTxt = fiveDayForecastInfo[i]['dt_txt'].split(' ');
      dtTxtDate = dtTxt[0];
      dtTxtTime = dtTxt[1];

      //Today:
      todayMinMax = [
        fiveDayForecastInfo[i]['main']['temp_min'],
        fiveDayForecastInfo[i]['main']['temp_max']
      ];
      condition = fiveDayForecastInfo[i]['weather'][0]['id'];

      // Today Time Slots:
      if (dtTxt[0] == fiveDayForecastInfo[0]['dt_txt'].split(' ')[0]) {
        final tempTime = int.parse(dtTxtTime.split(':')[0]);
        final pmTime = tempTime > 12 ? tempTime - 12 : tempTime;
        todayTimeSlots.add(tempTime > 11 ? '$pmTime PM' : '$tempTime AM');
      }

      // Five Day Forecast Data:
      (fiveDaysForecastFormatted.containsKey(dtTxtDate))
          ? fiveDaysForecastFormatted.update(
              dtTxtDate, (value) => value + todayMinMax)
          : () {
              fiveDaysForecastFormatted.putIfAbsent(
                  dtTxtDate, () => todayMinMax);
              fiveDayForecastWeatherCondition.add(condition);
            }();
    }

    // Five Day Forecast Data:
    fiveDayForecastDates = fiveDaysForecastFormatted.keys.toList();
    fiveDayForecastTempratures = fiveDaysForecastFormatted.values.toList();
    fiveDayForecastWeatherCondition.toList();

    _fiveDaysForecastJSON = {
      'todaysForecast': {
        'minMax': todayMinMax,
        'timeSlots': todayTimeSlots,
      },
      'weeklyForecast': {
        'dateList': fiveDayForecastDates,
        'tempraturesList': fiveDayForecastTempratures,
        'conditionList': fiveDayForecastWeatherCondition
      }
    };
  }

  IconData getWeatherIcon(int condition) {
    if (condition < 300) {
      return WeatherIcons.thunderstorm;
    } else if (condition < 400) {
      return WeatherIcons.sprinkle;
    } else if (condition < 600) {
      return WeatherIcons.rain;
    } else if (condition < 700) {
      return WeatherIcons.snow;
    } else if (condition < 800) {
      return WeatherIcons.fog;
    } else if (condition == 800) {
      return WeatherIcons.day_sunny;
    } else if (condition <= 804) {
      return WeatherIcons.cloudy;
    } else {
      return WeatherIcons.cloud_refresh;
    }
  }
}
