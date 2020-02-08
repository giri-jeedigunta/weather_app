import 'package:geolocator/geolocator.dart';

class LocationService {
  double latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      final position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      latitude = position.latitude;
      longitude = position.longitude;
    } on Exception catch (e) {
      print('Location Service Error : $e');
    }
  }
}
