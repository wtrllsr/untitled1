import 'package:WeatherApp/model/Weather.dart';
import 'package:flutter/widgets.dart';

import 'WeatherCard.dart';

class HourlyWeather extends StatelessWidget {
  final List<Weather> hourlyWeather;

  const HourlyWeather({Key key, this.hourlyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * .50,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 5,
            itemBuilder: (context, i) {
              return WeatherCard(
                title:
                    '${hourlyWeather[i].time.hour}:${hourlyWeather[i].time.minute}0',
                temperature: hourlyWeather[i].temperature.toInt(),
                iconCode: hourlyWeather[i].iconCode,
                description: hourlyWeather[i].description,
                temperatureFontSize: 30,
                iconScale: 1
              );

            }));
  }
}
