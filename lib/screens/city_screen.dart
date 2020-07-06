import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New City'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save',
            onPressed: () {
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
            },
          ),
        ],
      ),
      body: Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage('images/city_background.jpg'),
//            fit: BoxFit.cover,
//          ),
//        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value){
                    cityName= value;
                    print(cityName);
                  },
                ),
              ),
//              FlatButton(
//                onPressed: () {
//                  Navigator.pop(context, cityName);
//                },
//                child: Text(
//                  'Get Weather',
//                  style: kButtonTextStyle,
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
