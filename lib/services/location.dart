import 'package:geolocator/geolocator.dart';

// get current location coordinated

class Location{

  double lattitude, longitude;
  String locError;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      lattitude=position.latitude;
      longitude=position.longitude;
    } catch (e) {
      print(e);
    }
  }

}