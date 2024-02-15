import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print('Error: $e');
    }
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
        return; // Exit the function if permission is denied
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied');
      return; // Exit the function if permission is denied forever
    }
  }
}
