import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/pages/Places.dart';
import '../Data/my_data.dart';

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
  }
}
