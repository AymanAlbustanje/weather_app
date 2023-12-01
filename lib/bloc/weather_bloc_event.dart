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

class FetchHourlyForecast extends WeatherBlocEvent {
  final Position position;

  FetchHourlyForecast(this.position);

  @override
  List<Object> get props => [position];
}

class FetchDailyForecast extends WeatherBlocEvent {
  final Position position;

  FetchDailyForecast({required this.position});

  @override
  List<Object> get props => [position];
}

class FetchWeatherByCityName extends WeatherBlocEvent {
  final Place place;

  const FetchWeatherByCityName(this.place);

  @override
  List<Object> get props => [place];
}
