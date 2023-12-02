part of 'weather_bloc_bloc.dart';

class WeatherBlocState extends Equatable {
  const WeatherBlocState();

  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherBlocState {}

final class weatherblocLoading extends WeatherBlocState {}

final class weatherblocFailure extends WeatherBlocState {}

final class weatherblocSuccess extends WeatherBlocState {
  final Weather weather;
  const weatherblocSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}
