import 'dart:io';

import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import '../utilities/localInteraction.dart';
import 'location_screen.dart';

//Initial Loading screen that redirects to Location Screen

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LocalStorage lStorage = LocalStorage();
  WeatherModel weatherModel = WeatherModel();
  double latitude, longitude;

  @override
  Future<void> initState()  {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {

    await lStorage.writeFile(writeMode: FileMode.write, inputText: 'Local', isCityNameFile: null);
    var weatherData = await weatherModel.getLocationWeather();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(locationWeather: weatherData,);
        },
      ),
    );
  }

  Widget build(BuildContext context) {
//    Timer.run(() => getLocationData());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'images/LoadingWedges.gif',
          height: 100,
          width: 100,
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
