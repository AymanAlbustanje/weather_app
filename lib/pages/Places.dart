import 'package:flutter/material.dart';

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
            style: TextStyle(
              color: Colors.black,
            ),
            'Places'),
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
    Place(code: 'NYC', name: 'New York City'),
    Place(code: 'SF', name: 'San Francisco'),
    Place(code: 'LA', name: 'Los Angeles'),
    // Add more places as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return PlaceCard(place: places[index]);
      },
    );
  }
}

class Place {
  final String code;
  final String name;

  Place({required this.code, required this.name});
}

class PlaceCard extends StatelessWidget {
  final Place place;

  PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    // For simplicity, showing a placeholder weather text
    String weather = 'Sunny';

    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(place.name),
        subtitle: Text('Weather: $weather'), // Replace with actual weather data
        onTap: () {
          // Navigate to a detailed weather screen or handle the tap event
          // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => PlaceDetailsScreen(place)));
        },
      ),
    );
  }
}
