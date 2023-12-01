import 'package:flutter/material.dart';
import 'package:weather_app/pages/places_details.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/Data/my_data.dart';

class Places extends StatefulWidget {
  const Places({Key? key}) : super(key: key);

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 195, 218, 228),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 135, 206, 235),
        title: const Text(
          'Places',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: PlacesList(),
    );
  }
}

class PlacesList extends StatefulWidget {
  @override
  _PlacesListState createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  final List<Place> places = [
    Place(
      code: 'NYC',
      name: 'New York City',
    ),
    Place(
      code: 'KU',
      name: 'Kuwait',
    ),
    Place(
      code: 'PAR',
      name: 'Paris',
    ),
    Place(
      code: 'LON',
      name: 'London',
    ),
    Place(
      code: 'SYR',
      name: 'Syria',
    ),
    Place(
      code: 'JOR',
      name: 'Jordan',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fetchInitialWeatherData();
  }

  Future<void> _fetchInitialWeatherData() async {
    for (var place in places) {
      await _fetchWeatherData(place);
    }
  }

  Future<void> _fetchWeatherData(Place place) async {
    try {
      WeatherFactory wf = WeatherFactory(API_KEY);
      Weather weather = await wf.currentWeatherByCityName(place.name);
      setState(() {
        place.temperature = weather.temperature!.celsius;
        place.weatherIcon = Icons.wb_sunny;
      });
    } catch (e) {
      print('Error fetching weather data for ${place.name}: $e');
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return PlaceCard(
          place: places[index],
        );
      },
    );
  }
}

class Place {
  final String code;
  final String name;
  double? temperature;
  IconData? weatherIcon;

  Place({
    required this.code,
    required this.name,
    this.temperature,
    this.weatherIcon,
  });
}

class PlaceCard extends StatelessWidget {
  final Place place;

  PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: Color.fromARGB(255, 143, 208, 234),
        title: Text(place.name),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetails(cityName: place.name),
            ),
          );
        },
        subtitle: place.temperature != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Temperature: ${place.temperature!.round()}°C          Click for Details'),
                  Spacer(),
                  _buildWeatherIcon(place.temperature!),
                ],
              )
            : Text('Fetching weather data...'),
      ),
    );
  }

  Icon _buildWeatherIcon(double temperature) {
    if (temperature > 20) {
      return Icon(Icons.wb_sunny);
    } else if (temperature <= 20 && temperature > 10) {
      return Icon(Icons.cloud);
    } else {
      return Icon(Icons.cloudy_snowing);
    }
  }
}
