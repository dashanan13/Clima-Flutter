import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/reusable_card.dart';
import 'package:flutter/material.dart';

//This file deals with detailed weather of each city

class CityDetails extends StatefulWidget {
  final cityDetailsinfo;
  CityDetails({this.cityDetailsinfo});
  @override
  _CityDetailsState createState() => _CityDetailsState();
}

class _CityDetailsState extends State<CityDetails> {
  WeatherModel weather = WeatherModel();
  double temperature;
  String cityName, countryName, weatherIcon, weatherMessage;
  DateTime dateTimeData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.cityDetailsinfo);
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
        weatherIcon = (weatherData['weather'][0]['icon']).toString();
        weatherMessage = weatherData['weather'][0]['main'];
        cityName = weatherData['name'];
        countryName = weatherData['sys']['country'];
        dateTimeData = DateTime.fromMillisecondsSinceEpoch(
            ((weatherData['dt']) + (weatherData['timezone'])) * 1000,
            isUtc: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arbeid Weather'),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: null,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: null,
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
        child: SingleChildScrollView(
          child: SafeArea(
            child: ReusableCard(
              colour: Colors.black.withOpacity(0.6),
              cardChild: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //****Display city name and country
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$cityName, $countryName',
                      textAlign: TextAlign.center,
                      style: kBoldTextStyle,
                    ),
                  ),
                  //****Display city date and time
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            'Date: ${dateTimeData.day}-${dateTimeData.month}-${dateTimeData.year}',
                            textAlign: TextAlign.center,
                            style: kMessageTextStyle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Time: ${dateTimeData.hour}:${dateTimeData.minute}',
                            textAlign: TextAlign.center,
                            style: kMessageTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //****Display weather icon and description
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            weatherMessage,
                            textAlign: TextAlign.left,
                            style: kNormalTextStyle,
                          ),
                          Image.asset(
                            'images/$weatherIcon@2x.png',
                            height: 100,
                            width: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                  //****Display Temperatures
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Minimum',
                              style: kMessageTextStyle,
                            ),
                            Text(
                              '15' + '°C',
                              style: kNormalTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Current',
                              style: kMessageTextStyle,
                            ),
                            Text(
                              '30' + '°C',
                              style: kButtonTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Maximum',
                              style: kMessageTextStyle,
                            ),
                            Text(
                              '45' + '°C',
                              style: kNormalTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                  //****Display current day hourly forecast
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Today\'s forcast',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 100.0,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: <Widget>[
                              Container(
                                width: 80.0,
                                color: Colors.red,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.blue,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.green,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.purple,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.orange,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.teal,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.grey,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.black,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.greenAccent,
                              ),
                              Container(
                                width: 80.0,
                                color: Colors.lightGreenAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //****Display Next 5 day's forecast
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Weekly forcast',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 400,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              Container(
                                height: 80.0,
                                color: Colors.red,
                              ),
                              Container(
                                height: 80.0,
                                color: Colors.blue,
                              ),
                              Container(
                                height: 80.0,
                                color: Colors.orange,
                              ),
                              Container(
                                height: 80.0,
                                color: Colors.teal,
                              ),
                              Container(
                                height: 80.0,
                                color: Colors.grey,
                              ),
                              Container(
                                height: 80.0,
                                color: Colors.black,
                              ),
                              Container(
                                height: 80.0,
                                color: Colors.greenAccent,
                              ),
                              Container(
                                height: 80.0,
                                color: Colors.lightGreenAccent,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
