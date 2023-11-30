import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';

import '../bloc/weather_bloc_bloc.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 218, 228),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 206, 235),
        title: const Text('Hourly Forecast', style: TextStyle(color: Colors.black)),
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
            if (state is WeatherblocHourlyForecast) {
              List<Weather> hourlyForecast = state.hourlyForecast;
              return TileList(hourlyForecast: hourlyForecast);
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
  final List<Weather> hourlyForecast;

  TileList({required this.hourlyForecast});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hourlyForecast.length,
      itemBuilder: (context, index) {
        Weather hourWeather = hourlyForecast[index];

        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Card(
            color: Color.fromARGB(255, 135, 206, 235),
            elevation: 5.0,
            child: ListTile(
              title: Text('After $index Hours'),
              subtitle: Text('Temperature: ${hourWeather.temperature!.celsius!.round()}°C'),
              trailing: Icon(Icons.sunny), // Add your desired icon
            ),
          ),
        );
      },
    );
  }
}
