import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/daily%20weather%20bloc/dailyweather_bloc.dart';

class DailyForecast extends StatefulWidget {
  @override
  _DailyForecastState createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {
  final DailyWeatherBloc _dailyWeatherBloc = DailyWeatherBloc();

  @override
  void initState() {
    super.initState();

    double yourLatitude = 37.7749;
    double yourLongitude = -122.4194;

    // Dispatch the FetchDailyWeather event with the desired latitude and longitude
    _dailyWeatherBloc.add(FetchDailyWeather(yourLatitude, yourLongitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Forecast'),
      ),
      body: BlocBuilder<DailyWeatherBloc, DailyweatherState>(
        builder: (context, state) {
          if (state is DailyWeatherLoading) {
            return CircularProgressIndicator();
          } else if (state is DailyWeatherSuccess) {
            // Display daily weather information
            return buildDailyWeatherList(state.dailyWeather);
          } else if (state is DailyWeatherFailure) {
            return Text('Failed to fetch daily weather');
          }

          return Container(); // Add other cases if needed
        },
      ),
    );
  }

  Widget buildDailyWeatherList(List<Weather> dailyWeather) {
    return ListView.builder(
      itemCount: dailyWeather.length,
      itemBuilder: (context, index) {
        // Build UI for each item in the daily weather list
        // Access dailyWeather[index] for individual weather details
        return ListTile(
          title: Text('Date: ${dailyWeather[index].date}'),
          // Add more details based on your requirements
        );
      },
    );
  }

  @override
  void dispose() {
    _dailyWeatherBloc.close();
    super.dispose();
  }
}
