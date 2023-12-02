class WeatherData {
  final String dateTime;
  final double temperature;
  final String weatherDescription;
  // Add other properties as needed

  WeatherData({
    required this.dateTime,
    required this.temperature,
    required this.weatherDescription,
    // Add other named parameters as needed
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      dateTime: json['dt_txt'],
      temperature: json['main']['temp'].toDouble(),
      weatherDescription: json['weather'][0]['description'],
      // Parse other properties accordingly
    );
  }
}

List<WeatherData> parseForecastData(Map<String, dynamic> data) {
  List<WeatherData> forecast = [];
  if (data['list'] != null) {
    for (var entry in data['list']) {
      forecast.add(WeatherData.fromJson(entry));
    }
  }
  return forecast;
}
