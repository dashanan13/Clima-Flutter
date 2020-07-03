import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

const apiKey = '29648725080b48e093bf9ae1f7c1cde3';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  double latitude, longitude;

  void initState(){
    super.initState();
//    print('>>>>>>>>>>>>>>>>>>>init<<<<<<<<<<<<<<<<<<<<<<<<<<');
    getLocationData();
  }

  void getLocationData() async{
    Location location =Location();
    await location.getCurrentLocation();

    latitude = location.lattitude;
    longitude = location.longitude;

    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    print(weatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
//      body: Center(
//        child: RaisedButton(
//          onPressed: () {
//            print('build');
//            getLocationData();//Get the current location
//          },
//          child: Text('Get Location'),
//        ),
//
//      ),
    );
  }
}

