import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Data/my_data.dart';

part 'dailyweather_event.dart';
part 'dailyweather_state.dart';

class DailyWeatherBloc extends Bloc<DailyweatherEvent, DailyweatherState> {
  DailyWeatherBloc() : super(DailyWeatherLoading());

  Stream<DailyweatherState> mapEventToState(DailyweatherEvent event) async* {
    if (event is FetchDailyWeather) {
      yield DailyWeatherLoading();

      try {
        WeatherFactory wf = WeatherFactory(API_KEY);

        List<Weather> dailyWeather = await wf.fiveDayForecastByLocation(event.latitude, event.longitude);

        yield DailyWeatherSuccess(dailyWeather);
      } catch (e) {
        yield DailyWeatherFailure();
      }
    }
  }
}
