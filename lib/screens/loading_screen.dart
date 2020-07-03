import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '29648725080b48e093bf9ae1f7c1cde3';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  double latitude, longitude;

  void getLocation() async{
    Location location =Location();
    await location.getCurrentLocation();

    latitude = location.lattitude;
    longitude = location.longitude;
    print(latitude.toString() + ' ' + longitude.toString());
    getData();
  }

  void getData() async{
    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedDara = jsonDecode(data);
      var temperature = decodedDara['main']['temp'];
      var condition = decodedDara['weather'][0]['id'];
      var cityname = decodedDara['name'];
      var lat = decodedDara['coord']['lon'];
      var lon = decodedDara['coord']['lat'];

      print(temperature);
      print(condition);
      print(cityname);
      print(lat);
      print(lon);
      print('https://samples.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    }
    else{
      print(response.statusCode);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocation();//Get the current location
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}

