import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/screens/city_details.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/reusable_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:time_formatter/time_formatter.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  double temperature;
  String cityName, countryName, weatherIcon, weatherMessage;
  DateTime dateTimeData;

  @override
  void initState() {
    // TODO: implement initState
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data!';
        cityName = '';
        countryName = '';
      } else {
        temperature = double.parse((weatherData['main']['temp']).toString());
        var condition = weatherData['weather'][0]['id'];
//        weatherIcon = weather.getWeatherIcon(condition);
//        weatherMessage = weather.getMessage(temperature.toInt());
        weatherIcon = (weatherData['weather'][0]['icon']).toString();
        weatherMessage = weatherData['weather'][0]['main'];
        cityName = weatherData['name'];
        countryName = weatherData['sys']['country'];
        dateTimeData = DateTime.fromMillisecondsSinceEpoch(
            ((weatherData['dt']) + (weatherData['timezone'])) * 1000,
            isUtc: true);
        print(DateTime.fromMillisecondsSinceEpoch(
            ((1593910050) + (-18000)) * 1000,
            isUtc: true));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arbeid Weather'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add_circle_outline),
              tooltip: 'New City',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return _MyDialog();
                    });
              },
              ),
//              onPressed: () async {
//                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context) { return CityScreen(); },),);
//                      if (typedName != null) {
//                        var weatherData =
//                            await weather.getCityWeather(typedName);
//                        updateUI(weatherData);
//                      }
//                    },
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () async {
              var weatherData = await weather.getLocationWeather();
              updateUI(weatherData);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child:
//**************************************
              Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ReusableCard(
                colour: Colors.black.withOpacity(0.8),
                cardChild: FlatButton(
                  onPressed: () async {
                    var weatherData = await weather.getLocationWeather();
                    updateUI(weatherData);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CityDetails(
                        cityDetailsinfo: weatherData,
                      );
                    }));
                  },
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '$cityName, $countryName',
                              textAlign: TextAlign.left,
                              style: kBoldTextStyle,
                            ),
                            Text(
                              '${dateTimeData.day}-${dateTimeData.month}-${dateTimeData.year} ${dateTimeData.hour}:${dateTimeData.minute}',
                              textAlign: TextAlign.left,
                              style: kNormalTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'images/$weatherIcon@2x.png',
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            weatherMessage,
                            textAlign: TextAlign.left,
                            style: kNormalTextStyle,
                          ),
                          Text(
                            temperature.toInt().toString() + '°',
                            textAlign: TextAlign.left,
                            style: kBoldTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            tooltip: 'Settings',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),

//**************************************
//              Column(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  FlatButton(
//                    onPressed: () async {
//                      var weatherData = await weather.getLocationWeather();
//                      updateUI(weatherData);
//                    },
//                    child: Icon(
//                      Icons.near_me,
//                      size: 20.0,
//                    ),
//                  ),
//                  FlatButton(
//                    onPressed: () async {
//                      var typedName = await Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) {
//                            return CityScreen();
//                          },
//                        ),
//                      );
//                      if (typedName != null) {
//                        var weatherData =
//                            await weather.getCityWeather(typedName);
//                        updateUI(weatherData);
//                      }
//                    },
//                    child: Icon(
//                      Icons.location_city,
//                      size: 50.0,
//                    ),
//                  ),
//                ],
//              ),
//              Padding(
//                padding: EdgeInsets.only(left: 15.0),
//                child: Row(
//                  children: <Widget>[
//                    Text(
//                      temperature.toInt().toString() + '°',
//                      style: kTempTextStyle,
//                    ),
//                    Text(
//                      weatherIcon,
//                      style: kConditionTextStyle,
//                    ),
//                  ],
//                ),
//              ),
//              Padding(
//                padding: EdgeInsets.only(left: 15.0),
//                child: Text(
//                  '$weatherMessage in $cityName',
//                  textAlign: TextAlign.left,
//                  style: kMessageTextStyle,
//                ),
//              ),
//            ],
//          ),
        ),
      ),
    );
  }
}

class _MyDialog extends StatefulWidget {
//  final String newCity;
//  final Widget dialogWidget;
//  _MyDialog({this.newCity, this.dialogWidget});
  _MyDialog();

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  List<String> _tempSelectedCities = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withOpacity(0.7),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
      insetPadding: EdgeInsets.all(30),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select a new city...',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                decoration: kTextFieldInputDecoration,
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.green.withOpacity(.8),
                    elevation: 20,
                    onPressed: () {},
                    child: const Text('Save',style: TextStyle(fontSize: 15,),
                    ),
                  ),
                  SizedBox(width: 20,),
                  RaisedButton(
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.red.withOpacity(.8),
                    elevation: 20,
                    onPressed: () {},
                    child: const Text('Discard',style: TextStyle(fontSize: 15,),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
