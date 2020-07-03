import 'dart:math';

import 'package:geolocator/geolocator.dart';

class Location{

  double lattitude, longitude;

  Future<void> getCurrentLocation()async {
    try {
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      lattitude=position.latitude;
      longitude=position.longitude;
    } catch (e) {
      print(e);
    }
  }
}