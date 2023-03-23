import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class WeatherModel {
  String date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;

  WeatherModel(
      {required this.date,
        required this.temp,
        required this.maxTemp,
        required this.minTemp,
        required this.weatherStateName});

  factory WeatherModel.fromjson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    return WeatherModel(
        date: data['location']['localtime'],
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        weatherStateName: jsonData['condition']['text']);
  }

  @override
  String toString() {
    return 'tem = $temp minTemp = $minTemp date = $date';
  }

  String getImage() {
    if (weatherStateName == 'clear' || weatherStateName == 'Light Cloud') {
      return 'assets/images/clear.png';
    } else if (weatherStateName == 'Sleet' ||
        weatherStateName == 'Snow' ||
        weatherStateName == 'Hail') {
      return 'assest/images/snow.png';
    } else if (weatherStateName == 'Light Rain' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers') {
      return 'assets/images/rain.png';
    } else if (weatherStateName == 'Thunderstom' ||
        weatherStateName == 'Thunder') {
      return 'assets/images/tthunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  MaterialColor getThemeColor() {
    if (weatherStateName == 'clear' ||
        weatherStateName == 'Sunny' ||
        weatherStateName == 'Light Cloud') {
      return Colors.orange;
    } else if (weatherStateName == 'Sleet' ||
        weatherStateName == 'Snow' ||
        weatherStateName == 'Hail') {
      return Colors.blue;
    } else if (weatherStateName == 'Light Rain' ||
        weatherStateName == 'Heavy Rain' ||
        weatherStateName == 'Showers') {
      return Colors.blueGrey;
    } else if (weatherStateName == 'Thunderstom' ||
        weatherStateName == 'Thunder') {
      return Colors.blue;
    } else {
      return Colors.lightGreen;
    }
  }
}
