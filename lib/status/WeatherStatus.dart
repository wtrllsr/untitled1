import 'package:WeatherApp/model/Weather.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherStatus extends Equatable {
  const WeatherStatus();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherStatus {}

class WeatherLoadInProgress extends WeatherStatus {}

class WeatherLoadSuccess extends WeatherStatus {
  final Weather weather;
  final List<Weather> hourlyWeather;

  const WeatherLoadSuccess(
      {@required this.weather, @required this.hourlyWeather})
      : assert(weather != null);

  @override
  List<Object> get props => [weather, hourlyWeather];
}

class WeatherLoadFailure extends WeatherStatus {}
