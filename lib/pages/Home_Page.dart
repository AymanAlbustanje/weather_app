import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/link.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import '../Others/MyDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Lottie.asset('assets/thunder.json');
      case > 500 && <= 599:
        return Lottie.asset('assets/rain.json');
      case > 600 && <= 700:
        return Lottie.asset('assets/snow.json');
      case 800:
        return Lottie.asset('assets/sunny.json');
      case > 800 && <= 804:
        return Lottie.asset('assets/cloudy.json');
      default:
        return Lottie.asset('assets/sunny.json');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 195, 218, 228),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 135, 206, 235),
        title: const Text(
            style: TextStyle(
              color: Colors.black,
            ),
            "My Weather App"),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
          builder: (context, state) {
            if (state is weatherblocSuccess) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getWeatherIcon(state.weather.weatherConditionCode!),
                  // weather discribtion
                  Text(
                    '${state.weather.weatherMain}',
                    style: const TextStyle(fontSize: 30),
                  ),
                  // city
                  Text(
                    '${state.weather.areaName}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  //temp
                  Text(
                    '${state.weather.temperature!.celsius!.round()}°C',
                    style: const TextStyle(fontSize: 17),
                  ),
                  Text(""),
                  Text(""),
                  Link(
                    uri: Uri.parse('https://www.google.com/maps'),
                    builder: (context, followLink) {
                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(const Color.fromARGB(255, 135, 206, 235))),
                          onPressed: followLink,
                          child: const Text(
                            "Open Google Maps",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ));
                    },
                  )
                ],
              );
            } else {}
            return Container();
          },
        ),
      ),
    );
  }
}
