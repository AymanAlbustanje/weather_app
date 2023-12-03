part of 'daily_weather_bloc.dart';

abstract class DailyWeatherEvent extends Equatable {
  const DailyWeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchDailyWeather extends DailyWeatherEvent {
  final String cityName;

  const FetchDailyWeather(this.cityName);

  @override
  List<Object> get props => [cityName];
}
