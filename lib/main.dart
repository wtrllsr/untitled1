import 'package:WeatherApp/search/SearchDelegate.dart';
import 'package:WeatherApp/event/WeatherEvent.dart';
import 'package:WeatherApp/status/WeatherStatus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/WeatherBloc.dart';
import 'ui/MainScreenWrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white,),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(),
      child: BlocBuilder<WeatherBloc, WeatherStatus>(
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            return Scaffold(

              appBar: AppBar(

                title: Text('Weather'),
                centerTitle: true,
                backgroundColor: Colors.black45,
                elevation: 0,
                actions: [
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.my_location),
                    onPressed: () {
                      BlocProvider.of<WeatherBloc>(context).add(WeatherCurrentPositionRequested());
                    },
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                          context: context, delegate: MySearchDelegate((query) {
                            BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: query));
                      }));
                    },
                  )
                ],
              ),
              body: MainScreenWrapper(
                    weather: state.weather, hourlyWeather: state.hourlyWeather)
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromRGBO(0, 0, 0, 0),
              actions: [
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.my_location),
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context).add(WeatherCurrentPositionRequested());
                  },
                ),
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: MySearchDelegate((query) {
                      BlocProvider.of<WeatherBloc>(context).add(WeatherRequested(city: query));
                    }));
                  },
                )
              ],
            ),
            body: Center(
              child: CircularProgressIndicator(),
            )
          );
        },
      ),
    );
  }
}
