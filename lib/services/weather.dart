import 'package:clima/services/location.dart';
import 'networking.dart';

// Gets weather information by coordinated and location names

const apiKey = '29648725080b48e093bf9ae1f7c1cde3';
const openWeathermapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getCityWeather(String cityName) async {
    String formatText = cityName.replaceAll(' ', '+');
    NetworkHelper networkHelper = NetworkHelper('$openWeathermapURL?q=$formatText&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getCoordinateWeather(double latitude, double longitude) async {
    NetworkHelper networkHelper = NetworkHelper('$openWeathermapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather () async {
    Location location =Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper('$openWeathermapURL?lat=${location.lattitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
