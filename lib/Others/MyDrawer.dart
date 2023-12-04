import 'package:flutter/material.dart';
import 'package:weather_app/pages/Daily_forecast.dart';
import 'package:weather_app/pages/Hourly_forecast.dart';
import 'package:weather_app/pages/Places.dart';

import '../pages/Home_Page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 195, 218, 228),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 135, 206, 235),
            ),
            child: Text(
              'Weather App',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomePage()));
            },
          ),
          ListTile(
            title: const Text('Hourly Forecast'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HourlyForecast()));
            },
          ),
          ListTile(
            title: const Text('Daily Forecast'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DailyForecast()));
            },
          ),
          ListTile(
            title: const Text('Places'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Places()));
            },
          ),
        ],
      ),
    );
  }
}
