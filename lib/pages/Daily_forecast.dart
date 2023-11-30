import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';

import '../bloc/weather_bloc_bloc.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 218, 228),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 206, 235),
        title: const Text('Daily Forecast', style: TextStyle(color: Colors.black)),
      ),
      body: BlocProvider(
        create: (context) => WeatherBlocBloc(),
        child: BlocConsumer<WeatherBlocBloc, WeatherBlocState>(
          listener: (context, state) {
            if (state is weatherblocFailure) {
              // Handle failure, show an error message, etc.
            }
          },
          builder: (context, state) {
            if (state is WeatherblocDailyForecast) {
              List<Weather> dailyForecast = state.dailyForecast;
              return TileList(dailyForecast: dailyForecast);
            } else if (state is weatherblocLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Failed to load weather data'));
            }
          },
        ),
      ),
    );
  }
}

class TileList extends StatelessWidget {
  final List<Weather> dailyForecast;

  TileList({required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dailyForecast.length,
      itemBuilder: (context, index) {
        Weather dayWeather = dailyForecast[index];

        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            color: Color.fromARGB(255, 135, 206, 235),
            elevation: 5.0,
            child: ListTile(
              title: Text('Day ${index + 1}'),
              subtitle: Text('Temperature: ${dayWeather.temperature!.celsius!}°C'),
              trailing: Icon(Icons.wb_sunny), // Add your desired icon
            ),
          ),
        );
      },
    );
  }
}
