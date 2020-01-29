import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/api_helper.dart';
import 'package:weather_app/utils/loaction_helper.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherHelper {
  Future<dynamic> getLocationWeather() async {
    // Get current Location
    Location location = Location();
    await location.getCurrentLocation();

    // GET weather info of the location:
    ApiHelper apiHelper = ApiHelper(
        '$kWeatherApiUrl?lat=${location.latitude}&lon=${location.latitude}&appid=$kWeatherAppId&units=metric');

    // Using var as the data is dynamic:
    var weatherData = await apiHelper.getResponse();
    print('weather Data >> $weatherData');
    
    return weatherData;
    
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
