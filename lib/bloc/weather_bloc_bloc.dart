import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/pages/Places.dart';
import '../Data/my_data.dart';
import 'package:http/http.dart' as http;

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  final Dio dio = Dio();

  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(weatherblocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY);

        Weather weather = await wf.currentWeatherByLocation(
          event.position.latitude,
          event.position.longitude,
        );
        emit(weatherblocSuccess(weather));
      } catch (e) {
        emit(weatherblocFailure());
      }
    });
    on<FetchWeatherByCityName>((event, emit) async {
      emit(weatherblocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY);

        Weather weather = await wf.currentWeatherByCityName(event.place.name);
        emit(weatherblocSuccess(weather));
      } catch (e) {
        emit(weatherblocFailure());
      }
    });

    // Function to extract daily forecast from hourly forecast
    List<Weather> _extractDailyForecast(List<Weather> hourlyForecast) {
      List<Weather> dailyForecast = [];

      // Logic to extract daily forecast, e.g., take the first entry for each day
      for (int i = 0; i < hourlyForecast.length; i += 8) {
        dailyForecast.add(hourlyForecast[i]);
      }

      return dailyForecast;
    }

//     on<FetchDailyForecast>((event, emit) async {
//   emit(weatherblocLoading());
//   try {
//     // Use http to fetch the data
//     final apiKey = API_KEY;
//     final url = 'https://api.openweathermap.org/data/2.5/forecast?lat=${event.position.latitude}&lon=${event.position.longitude}&appid=$apiKey';

//     final response = await http.get(Uri.parse(url));

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       // Parse the data and create a list of Weather objects
//       List<Weather> dailyForecast = parseForecastData(data);
//       emit(WeatherblocDailyForecast(dailyForecast));
//     } else {
//       emit(weatherblocFailure());
//     }
//   } catch (e) {
//     emit(weatherblocFailure());
//   }
// });
  }
}
