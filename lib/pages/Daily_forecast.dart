import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class DailyForecast extends StatelessWidget {
  final List<Weather> dailyForecast;
  const DailyForecast({Key? key, required this.dailyForecast}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Daily Forecast'),
        ),
        body: Container());
  }
}
