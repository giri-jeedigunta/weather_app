import 'package:mobx/mobx.dart';
import 'package:weather_app/services/loaction_helper.dart';
import 'package:weather_app/services/weather_helper.dart';

part 'weather_store.g.dart';

class WeatherStore = _WeatherStore with _$WeatherStore;

abstract class _WeatherStore with Store {
  WeatherService weather = WeatherService();

  @observable
  double latitude, longitude;

  @observable
  Map<dynamic, dynamic> todaysWeather = {}, fiveDayWeatherForecast = {};

  @action
  Future<void> updateLocation() async {
    final location = LocationService();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;
  }

  @action
  Future<void> updateWeatherAndForecast(double lat, double long) async {
    todaysWeather = await weather.getLocationWeather(lat, long);
    fiveDayWeatherForecast = await weather.getFiveDayForecast(lat, long);
  }
}
