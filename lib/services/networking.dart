import 'package:http/http.dart' as http;
import 'dart:convert';

// Utility to intereact with API

class NetworkHelper{

  NetworkHelper(this.url);
  final String url;

  Future getData() async{
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }
    else{
      print('HTTP Fail: ${response.statusCode}');
    }
  }

}