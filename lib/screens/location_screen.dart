import 'file:///C:/MobileApps/Apps/Clima-Flutter/lib/utilities/localInteraction.dart';
import 'package:clima/utilities/mydialog.dart';
import 'package:clima/utilities/reusable_summary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Short summary list of all cities

class LocationScreen extends StatefulWidget {
  final locationWeather;
  LocationScreen({this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LocalStorage lStorageloc = LocalStorage();
  List<Card> myCityCards = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildcards();
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
                    return MyDialog( //A dialog box takes in a city and rebuilds the list of cities
                      dialogText: 'Select a city',
                      okButtonText: 'Save',
                      cancelButtonText: 'Discard',
                    );
                  }).then((_) =>
                  setState(() {
                    buildcards();
                  }));
            },
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: myCityCards,
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Card>> buildcards() async {
    var cities = await lStorageloc.readFile(isCityNameFile: true);
    myCityCards.clear();
    for (var i=0 ; i< (cities.length -1) ; i++) {
      setState(() {
        myCityCards.add(
            Card(
              color: Colors.black.withOpacity(0.0),
              margin: EdgeInsets.all(0.0),
              child: ReusableSummaryCard(tempCityName: cities[i].toString()),
            ),
        );
      });
    }
    return myCityCards;
  }

}
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