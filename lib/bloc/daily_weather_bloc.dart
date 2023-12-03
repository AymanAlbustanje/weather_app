import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/Data/my_data.dart';

part 'daily_weather_event.dart';
part 'daily_weather_state.dart';

class DailyWeatherBloc extends Bloc<DailyWeatherEvent, DailyWeatherState> {
  final Dio dio = Dio();

  DailyWeatherBloc() : super(DailyWeatherInitial());

  @override
  Stream<DailyWeatherState> mapEventToState(DailyWeatherEvent event) async* {
    if (event is FetchDailyWeather) {
      yield DailyWeatherLoading();
      try {
        // Make HTTP request to the weather API using dio
        // You need to replace 'YOUR_API_KEY' with your actual API key
        final response = await dio.get(
          'https://api.weatherapi.com/v1/forecast.json?key=$API_KEY&q=${event.cityName}&days=5',
        );

        // Parse the response and extract the necessary information
        final List<dynamic> forecastDays = response.data['forecast']['forecastday'];
        final List<WeatherData> dailyData = forecastDays
            .map((day) => WeatherData(
                  date: DateTime.parse(day['date']),
                  temperature: day['day']['avgtemp_c'].toDouble(),
                  description: day['day']['condition']['text'],
                  icon: day['day']['condition']['icon'],
                ))
            .toList();

        // Send the parsed data to the UI
        yield DailyWeatherSuccess(dailyData);
      } catch (e) {
        // Handle error
        yield DailyWeatherFailure();
      }
    }
  }
}
