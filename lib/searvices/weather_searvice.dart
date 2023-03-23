import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  String baseUrl = 'http://api.weatherapi.com/v1';

  String apiKey = '1068cb7d519546398c402920222009';

  Future<WeatherModel?> getWeather({required String cityName}) async {
    WeatherModel? weather;
    try {
      Uri url =
      Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');

      http.Response response = await http.get(url);

      Map<String, dynamic> data = jsonDecode(response.body);

      weather = WeatherModel.fromjson(data);
    } catch (e) {
      print(e);
    }
    return weather;
  }
}
