part of 'dailyweather_bloc.dart';

sealed class DailyweatherState extends Equatable {
  const DailyweatherState();

  @override
  List<Object> get props => [];
}

final class DailyweatherInitial extends DailyweatherState {}

class DailyWeatherLoading extends DailyweatherState {}

class DailyWeatherFailure extends DailyweatherState {}

class DailyWeatherSuccess extends DailyweatherState {
  final List<Weather> dailyWeather;

  const DailyWeatherSuccess(this.dailyWeather);

  @override
  List<Object> get props => [dailyWeather];
}
