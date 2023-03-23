import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/searvices/weather_searvice.dart';

class SearchPage extends StatefulWidget {

  SearchPage({this.updateUi});
  VoidCallback? updateUi;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? cityName;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search a City'),

        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://t4.ftcdn.net/jpg/03/97/07/27/360_F_397072723_78WD3dv1yVqflBOSoIycAyShIJ0DPJQN.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the City Name';
                  }
                  return null;
                },
                onChanged: (data)
                {
                  cityName = data;
                },
                onFieldSubmitted: (data) async {
                  cityName = data;

                  if(_formKey.currentState!.validate())
                  {
                    WeatherService service = WeatherService();

                    WeatherModel? weather =
                    await service.getWeather(cityName: cityName!);

                    Provider.of<WeatherProvider>(context, listen: false)
                        .weatherData = weather;
                    Provider.of<WeatherProvider>(context, listen: false).cityName =
                        cityName;
                    //updateUi!();
                    Navigator.pop(context);
                  }

                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  label: Text(
                    'Search',
                  ),
                  suffixIcon: GestureDetector(
                      onTap: () async {
                        if(_formKey.currentState!.validate())
                        {
                          WeatherService service = WeatherService();

                          WeatherModel? weather =
                          await service.getWeather(cityName: cityName!);

                          Provider.of<WeatherProvider>(context, listen: false)
                              .weatherData = weather;
                          Provider.of<WeatherProvider>(context, listen: false).cityName =
                              cityName;
                          //updateUi!();
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(Icons.search)),
                  border: OutlineInputBorder(),
                  hintText: 'Enter a city',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
