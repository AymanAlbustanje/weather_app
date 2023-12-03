part of 'weather_bloc_bloc.dart';

abstract class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherBlocEvent {
  final Position position;

  const FetchWeather(this.position);

  @override
  List<Object> get props => [position];
}

class FetchWeatherByCityName extends WeatherBlocEvent {
  final Place place;

  const FetchWeatherByCityName(this.place);

  @override
  List<Object> get props => [place];
}

class FetchDailyWeather extends WeatherBlocEvent {
  final Position position;
  final bool isDaily; // Define the 'isDaily' parameter

  const FetchDailyWeather(this.position, {this.isDaily = false}); // Set default value

  @override
  List<Object> get props => [position, isDaily]; // Update props to include 'isDaily'
}
