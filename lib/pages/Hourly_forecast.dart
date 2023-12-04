import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/Data/my_data.dart';

class HourlyForecast extends StatefulWidget {
  const HourlyForecast({Key? key}) : super(key: key);

  @override
  _HourlyForecastState createState() => _HourlyForecastState();
}

class _HourlyForecastState extends State<HourlyForecast> {
  final String apiKey = API_KEY;
  final String city = 'Palestine';

  List<Map<String, dynamic>>? hourlyForecast;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    const String endpoint = '/forecast';
    const String baseUrl = 'https://api.openweathermap.org/data/2.5';

    final Uri uri = Uri.parse('$baseUrl$endpoint');
    final Map<String, dynamic> params = {
      'q': city,
      'appid': apiKey,
    };

    final response = await http.get(uri.replace(queryParameters: params));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> hourlyList = data['list'];

      final now = DateTime.now();
      final nextHour = DateTime(now.year, now.month, now.day, now.hour + 0);
      final next24Hours = hourlyList.where((hourData) {
        final hourTime = DateTime.fromMillisecondsSinceEpoch(hourData['dt'] * 1000);
        return hourTime.isAfter(nextHour) && hourTime.isBefore(nextHour.add(const Duration(hours: 24)));
      }).toList();

      setState(() {
        hourlyForecast = next24Hours.cast<Map<String, dynamic>>();
      });
    } else {
      print("Failed to load hourly forecast. Status Code: ${response.statusCode}");
      throw Exception('Failed to load hourly forecast');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 218, 228),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 135, 206, 235),
        title: const Text('Hourly Forecast', style: TextStyle(color: Colors.black)),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(20.0), // Adjust the height as needed
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'the weather for the next 24 hours',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
      body: _buildHourlyList(),
    );
  }

  Widget _buildHourlyList() {
    if (hourlyForecast == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.separated(
        itemCount: hourlyForecast!.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8.0),
        itemBuilder: (context, index) {
          final hourData = hourlyForecast![index];
          final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(hourData['dt'] * 1000);
          final String hour = '${dateTime.hour}:${dateTime.minute}';

          // Convert temperature from Kelvin to Celsius
          final int temperatureInKelvin = (hourData['main']['temp'] as num).toInt();
          final int temperatureInCelsius = (temperatureInKelvin - 273.15).round();

          // Select icon based on temperature range
          IconData temperatureIcon = Icons.help;
          if (temperatureInCelsius < 10) {
            temperatureIcon = Icons.cloudy_snowing;
          } else if (temperatureInCelsius >= 20) {
            temperatureIcon = Icons.wb_sunny;
          } else {
            temperatureIcon = Icons.cloud;
          }

          return Card(
            elevation: 2.0,
            margin: const EdgeInsets.all(4.0),
            color: const Color.fromARGB(255, 143, 208, 234),
            child: ListTile(
              title: Text(hour),
              subtitle: Text('$temperatureInCelsius°C'),
              trailing: Icon(temperatureIcon),
            ),
          );
        },
      );
    }
  }
}
