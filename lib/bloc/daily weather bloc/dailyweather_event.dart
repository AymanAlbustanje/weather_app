part of 'dailyweather_bloc.dart';

abstract class DailyweatherEvent extends Equatable {
  const DailyweatherEvent();

  @override
  List<Object> get props => [];
}

class FetchDailyWeather extends DailyweatherEvent {
  final double latitude;
  final double longitude;

  const FetchDailyWeather(this.latitude, this.longitude);

  @override
  List<Object> get props => [latitude, longitude];
}
