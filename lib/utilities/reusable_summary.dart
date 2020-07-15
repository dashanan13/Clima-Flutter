import 'package:clima/screens/city_details.dart';
import 'package:clima/utilities/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:async';

// Reusable City summary page skeleton
// ignore: must_be_immutable

class ReusableSummaryCard extends StatefulWidget {
  final String tempCityName;

  ReusableSummaryCard({this.tempCityName});

  @override
  _ReusableSummaryCardState createState() => _ReusableSummaryCardState();
}

class _ReusableSummaryCardState extends State<ReusableSummaryCard> {
  WeatherModel weather = WeatherModel();
//  String _temperature, _weatherMessage, _cityName, _countryName, _dateTimeData;
//  Image _weatherIcon;
  // Repeatedly call for refresh
  Timer timer;

  Image _weatherIcon = Image.asset(
    'images/error_weather.png',
    height: 80,
    width: 80,
  );
  String _temperature = 'Swipe to remove';
  String _weatherMessage = 'Internet or API error';
  String _cityName = '-';
  String _countryName = '-';
  String _dateTimeData = '-';
  dynamic _cityWeatherData;

  void initState() {
    super.initState();
    getCityWeather();
  }
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  Future<void> getCityWeather() async {
    if (widget.tempCityName == 'Local') {
      _cityWeatherData = await weather.getLocationWeather();
    } else {
      _cityWeatherData = await weather.getCityWeather(widget.tempCityName);
    }
    getCitySummary(_cityWeatherData, widget.tempCityName);
  }

  void getCitySummary(dynamic _cityWeatherData, String tempCityName) {
    if (mounted) {
      setState(() {
//        print('getCitySummary: Mounted: $tempCityName');
        if (tempCityName.length > 0) {
          if (_cityWeatherData != null) {
            this._temperature = ((double.parse((_cityWeatherData['main']['temp']).toString())).toInt()).toString() + '°';
            String iconName = (_cityWeatherData['weather'][0]['icon']).toString();
            this._weatherIcon = Image.asset(
              'images/$iconName@2x.png',
              height: 80,
              width: 80,
            );
            this._weatherMessage = _cityWeatherData['weather'][0]['main'];
            this._cityName = _cityWeatherData['name'];
            this._countryName = _cityWeatherData['sys']['country'];
            DateTime tempdttm = DateTime.fromMillisecondsSinceEpoch(((_cityWeatherData['dt']) + (_cityWeatherData['timezone'])) *1000,isUtc: true);
            this._dateTimeData ='${tempdttm.day}-${tempdttm.month}-${tempdttm.year} ${tempdttm.hour}:${tempdttm.minute}';
          } else {
            _weatherMessage = 'Internet or API error';
          }
        } else {
          _weatherMessage = 'City name is 0 characters';
        }
      });
    }else{
      print('getCitySummary: Not Mounted: $tempCityName');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Repeatedly call for refresh
    if (mounted) { timer = new Timer.periodic(Duration(minutes: 60), (Timer t) => { setState((){ print('build:'); getCityWeather(); }) }); }
    else { dispose(); }

    return ReusableCard(
      colour: Colors.black.withOpacity(0.8),
      onPress: () {
        if (_cityName != '-') {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return CityDetails(
              cityDetailsinfo: _cityWeatherData,
            );
          }));
        }
      },
      cardChild: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '$_cityName, $_countryName',
                    textAlign: TextAlign.left,
                    style: kBoldTextStyle,
                  ),
                  Text(
                    _dateTimeData,
                    textAlign: TextAlign.left,
                    style: kNormalTextStyle,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _weatherIcon,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  _weatherMessage,
                  textAlign: TextAlign.left,
                  style: kNormalTextStyle,
                ),
                Text(
                  _temperature,
                  textAlign: TextAlign.left,
                  style: kBoldTextStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Refresh',
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        print('build: IconButton:  Mounted');
                        getCityWeather();
                      });
                    }else{
                      print('build: IconButton: NOT Mounted');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
