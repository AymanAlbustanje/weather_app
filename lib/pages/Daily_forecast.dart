import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/Data/my_data.dart';

class DailyForecast extends StatefulWidget {
  @override
  _DailyForecastState createState() => _DailyForecastState();
}

class _DailyForecastState extends State<DailyForecast> {
  final String apiKey = API_KEY;
  final String city = 'Palestine';
  final String apiUrl = 'http://api.openweathermap.org/data/2.5/forecast?q=Hebron&appid=$API_KEY';

  Future<Map<String, dynamic>> getWeatherData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  double kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 218, 228),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 206, 235),
        title: const Text(
          'Daily Weather Forecast',
          style: TextStyle(color: Colors.black),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'the weather for the next few days',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Parse the data
            List<dynamic> forecastList = snapshot.data!['list'];

            Map<String, List<dynamic>> groupedForecasts = {};
            for (var forecast in forecastList) {
              DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
              String date = '${dateTime.year}-${dateTime.month}-${dateTime.day}';

              if (!groupedForecasts.containsKey(date)) {
                groupedForecasts[date] = [];
              }

              groupedForecasts[date]!.add(forecast);
            }

            return ListView.separated(
              itemCount: groupedForecasts.entries.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8.0),
              itemBuilder: (context, index) {
                String date = groupedForecasts.entries.elementAt(index).key;
                List<dynamic> forecasts = groupedForecasts.entries.elementAt(index).value;

                double minTemp = double.infinity;
                double maxTemp = double.negativeInfinity;

                for (var forecast in forecasts) {
                  double temp = kelvinToCelsius(forecast['main']['temp'].toDouble());
                  minTemp = temp < minTemp ? temp : minTemp;
                  maxTemp = temp > maxTemp ? temp : maxTemp;
                }

                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.all(4.0),
                  color: const Color.fromARGB(255, 143, 208, 234),
                  child: ListTile(
                    title: Text(
                      'Date: $date',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Min Temp: ${minTemp.round()}°C, Max Temp: ${maxTemp.round()}°C',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
