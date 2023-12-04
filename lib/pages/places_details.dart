import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Data/my_data.dart';

class PlaceDetails extends StatelessWidget {
  final String cityName;

  PlaceDetails({required this.cityName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 218, 228),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 135, 206, 235),
        title: Text(cityName),
      ),
      body: FutureBuilder<Weather>(
        future: _fetchWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching weather data'));
          } else if (snapshot.hasData) {
            Weather weather = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow("Temperature", "${weather.temperature?.celsius!.round() ?? 'N/A'}°C"),
                  _buildInfoRow("Min Temperature", "${weather.tempMin?.celsius!.round() ?? 'N/A'}°C"),
                  _buildInfoRow("Max Temperature", "${weather.tempMax?.celsius!.round() ?? 'N/A'}°C"),
                  _buildInfoRow("Wind Speed", "${weather.windSpeed!.round()} m/s"),
                  _buildInfoRow("Humidity", "${weather.humidity!.round()}%"),
                  _buildInfoRow("Pressure", "${weather.pressure!.round()} hPa"),
                  _buildInfoRow("Description", "${weather.weatherDescription ?? 'N/A'}"),
                  _buildInfoRow("Cloudiness", "${weather.cloudiness!.round()}%"),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No weather data available'));
          }
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

  Future<Weather> _fetchWeatherData() async {
    try {
      WeatherFactory wf = WeatherFactory(API_KEY);
      return await wf.fiveDayForecastByCityName(cityName).then((value) => value.first);
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
