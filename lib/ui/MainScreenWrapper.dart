import 'package:WeatherApp/ui/WeatherHours.dart';
import 'package:WeatherApp/model/Weather.dart';
import 'package:flutter/widgets.dart';

import 'WeatherCard.dart';

class MainScreenWrapper extends StatelessWidget {
  final Weather weather;
  final List<Weather> hourlyWeather;

  const MainScreenWrapper({Key key, this.weather, this.hourlyWeather})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage('https://kartinkin.net/uploads/posts/2021-07/1626958209_21-kartinkin-com-p-bezhevie-oblaka-fon-krasivo-23.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(children: [

        Text(
          weather.cityName,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        WeatherCard(
          title: "Today",
          temperature: weather.temperature,
          iconCode: weather.iconCode,
          description: weather.description,
          temperatureFontSize: 48,
          iconScale: 1,
        ),
        // Text(

        Spacer(),

        HourlyWeather(hourlyWeather: this.hourlyWeather)
      ]),
    );
  }
}
