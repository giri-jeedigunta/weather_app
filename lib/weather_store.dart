import 'package:mobx/mobx.dart';
import 'package:weather_app/utils/loaction_helper.dart';

part 'weather_store.g.dart';

class WeatherStore = _WeatherStore with _$WeatherStore;

abstract class _WeatherStore with Store {
  @observable
  double latitude, longitude;


  @action
  Future<void> updateCoordinates() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;
  }
}