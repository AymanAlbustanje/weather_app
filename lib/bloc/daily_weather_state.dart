part of 'daily_weather_bloc.dart';

abstract class DailyWeatherState extends Equatable {
  const DailyWeatherState();

  @override
  List<Object> get props => [];
}

class DailyWeatherInitial extends DailyWeatherState {}

class DailyWeatherLoading extends DailyWeatherState {}

class DailyWeatherFailure extends DailyWeatherState {}

class DailyWeatherSuccess extends DailyWeatherState {
  final List<WeatherData> dailyData;

  const DailyWeatherSuccess(this.dailyData);

  @override
  List<Object> get props => [dailyData];
}

// New class to represent each day's weather information
class WeatherData extends Equatable {
  final DateTime date;
  final double temperature;
  final String description;
  final String icon;

  WeatherData({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  @override
  List<Object> get props => [date, temperature, description, icon];
}
