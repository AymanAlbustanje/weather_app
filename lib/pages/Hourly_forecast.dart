import 'package:flutter/material.dart';

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
        body: Container());
  }
}
