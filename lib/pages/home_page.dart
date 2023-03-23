import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/providers/weather_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void updateUi() {
    setState(() {});
  }

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(
                  updateUi: updateUi,
                );
              }));
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: Text(
          'Weather App',
        ),
        // backgroundColor: Colors.blue[900],
      ),
      body: weatherData == null
          ? Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://t3.ftcdn.net/jpg/01/79/15/24/360_F_179152446_d8gMu6db3bTdzldrmH1MXmkKk0sMymLR.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ' There is No Weather 🙂 \n Start Searching Now 🔍',
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      )
          : Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              weatherData!.getThemeColor(),
              weatherData!.getThemeColor()[300]!,
              weatherData!.getThemeColor()[100]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Text(
              Provider.of<WeatherProvider>(context).cityName ?? '',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              'update : ${weatherData!.date.toString()}',
              style: TextStyle(fontSize: 22),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  weatherData!.getImage(),
                  height: 100,
                  width: 100,
                ),
                Text(
                  weatherData!.temp.toInt().toString(),
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text('maxTemp : ${weatherData!.maxTemp.toInt()}'),
                    Text('minTemp : ${weatherData!.maxTemp.toInt()}'),
                  ],
                ),
              ],
            ),
            Spacer(),
            Text(
              weatherData!.weatherStateName,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
