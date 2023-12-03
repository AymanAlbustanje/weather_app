import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/daily_weather_bloc.dart';

class DailyForecast extends StatefulWidget {
  @override
  _DailyForecastState createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Forecast'),
      ),
      body: BlocBuilder<DailyWeatherBloc, DailyWeatherState>(
        builder: (context, state) {
          if (state is DailyWeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DailyWeatherSuccess) {
            // Display a list of daily weather information
            return buildDailyWeatherList(state.dailyData);
          } else if (state is DailyWeatherFailure) {
            return const Center(
              child: Text('Failed to fetch daily weather.'),
            );
          } else {
            return const Center(
              child: Text('Initial State'),
            );
          }
        },
      ),
    );
  }

  Widget buildDailyWeatherList(List<WeatherData> dailyData) {
    return ListView.builder(
      itemCount: dailyData.length,
      itemBuilder: (context, index) {
        var dayData = dailyData[index];
        var temperature = dayData.temperature;
        var weatherDescription = dayData.description;
        var iconCode = dayData.icon;
        var formattedDateTime = dayData.date;

        return ListTile(
          title: Text(
            '${formattedDateTime.day}/${formattedDateTime.month}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Temperature: ${temperature.toString()}°C'),
              Text('Description: $weatherDescription'),
            ],
          ),
          leading: Image.network('https://openweathermap.org/img/w/$iconCode.png'),
        );
      },
    );
  }
}
