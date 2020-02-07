import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/api_helper.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherHelper {
  Map<dynamic, dynamic> todaysWeatherJSON = {};
  Future<dynamic> getLocationWeather(lat, long) async {

    ApiHelper apiHelper = ApiHelper(
        '$kWeatherApiUrl?lat=$lat&lon=$long&appid=$kWeatherAppId&units=metric');

    // Using var as the data is dynamic:
    var weatherData = await apiHelper.getResponse();
    formatTodaysWeather(weatherData);

    return todaysWeatherJSON;
  }

  Future<dynamic> getFiveDayForecast(lat, long) async {
    // GET weather info of the location:
    ApiHelper apiHelper = ApiHelper(
        '$kForecastApiUrl?lat=$lat&lon=$long&appid=$kWeatherAppId&units=metric');

    // Using var as the data is dynamic:
    var forecastData = await apiHelper.getResponse();

    return forecastData;
  }

  void formatTodaysWeather(todaysWeatherInfo) {
    todaysWeatherJSON = {
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

  getWeatherIcon(int condition) {
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
