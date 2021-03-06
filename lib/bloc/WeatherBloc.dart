import 'dart:async';

import 'package:WeatherApp/event/WeatherEvent.dart';
import 'package:WeatherApp/model/Weather.dart';
import 'package:WeatherApp/weatherAPI/WeatherApi.dart';
import 'package:WeatherApp/status/WeatherStatus.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherStatus> {
  WeatherBloc() : super(null) {
    add(WeatherCurrentPositionRequested());
  }

  @override
  Stream<WeatherStatus> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield* _newWeatherRequested(event);
    }
    if (event is WeatherCurrentPositionRequested) {
      yield* _newWeatherCurrentPositionRequested();
    }
  }

  Stream<WeatherStatus> _newWeatherRequested(WeatherRequested event) async* {
    yield WeatherLoadInProgress();
    try {
      final Weather weather = await WeatherAPI.fetchCurrentWeather(
          query: event.city, lon: event.lon, lat: event.lat);
      final List<Weather> hourlyWeather =
          await WeatherAPI.fetchHourlyWeather(
              query: event.city, lon: event.lon, lat: event.lat);
      yield WeatherLoadSuccess(weather: weather, hourlyWeather: hourlyWeather);
    } catch (e) {
      yield WeatherLoadFailure();
    }
  }

  Stream<WeatherStatus> _newWeatherCurrentPositionRequested() async* {
    LocationPermission permission = await checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position lastKnownPosition = await getLastKnownPosition();
      if(lastKnownPosition != null) {
        add(WeatherRequested(
            lat: lastKnownPosition.latitude.toString(),
            lon: lastKnownPosition.longitude.toString()));

      } else {
        Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        add(WeatherRequested(
            lat: position.latitude.toString(),
            lon: position.longitude.toString()));
      }
    } else {
      await requestPermission();
      add(WeatherCurrentPositionRequested());
    }
  }
}
