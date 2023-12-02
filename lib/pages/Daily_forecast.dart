import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class DailyForecast extends StatelessWidget {
  final Position position;
  const DailyForecast({Key? key, required this.position}) : super(key: key);

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
              Text("error");
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
        return ListTile(
          title: Text('Day ${index + 1}'),
          subtitle: Text('Temperature: ${dailyForecast[index].temperature!.celsius!}°C'),
          trailing: Icon(Icons.wb_sunny),
        );
      },
    );
  }
}
