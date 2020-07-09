import 'networking.dart';

// Google API interactions

class GPlaces {
  String _gPlacesKey = 'AIzaSyDz_jgdGrd8w3hWA5j0lDDkA8glGFjTvsI';
  String _gGeoCodingKey = 'AIzaSyCQHHcAPapwZUQ80WG_ihcMDShZNLDtuio';
  List<String> _templocations = [
    'New York US',
    'Delhi, India',
    'Oslo, Norway',
  ];

  List<String> _tempCoordinates = ['0.0', '0.0'];

  List<String> _suggestions = [];

  Future<List> getSuggestions(String text) async {
    if ((text.isNotEmpty) && (text.length != 0)) {
      print(text);
      String queryURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&types=(cities)&key=$_gPlacesKey';
      NetworkHelper gplacesresponse = NetworkHelper(queryURL);
      var gplacespredictions = await gplacesresponse.getData();
      _suggestions = [
        gplacespredictions['predictions'][0]['description'],
        gplacespredictions['predictions'][1]['description'],
        gplacespredictions['predictions'][2]['description'],
      ];
      return _suggestions;
    } else {
      return _templocations;
    }
  }

  Future<void> getCoordinates(String text) async {
    if ((text.isNotEmpty) && (text.length != 0)) {
      String formatText = text.replaceAll(' ', '+');
      String queryURL ='https://maps.googleapis.com/maps/api/geocode/json?address=$formatText&key=$_gGeoCodingKey';
      NetworkHelper gplacesresponse = NetworkHelper(queryURL);
      var gplacespredictions = await gplacesresponse.getData();
      print(queryURL);
      print(gplacespredictions);
    } else {
//      return _tempCoordinates;
    }
  }


}
