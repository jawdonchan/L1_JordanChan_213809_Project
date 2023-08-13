import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _mapController;
  LatLng _center;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        setState(() {
          _center = LatLng(locations[0].latitude, locations[0].longitude);
        });

        _mapController.animateCamera(CameraUpdate.newLatLng(_center));
      }
    } catch (e) {
      print("Error searching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Map'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    _searchLocation("Bras Basah Cplx"); // Provide a default location to start
                  },
                ),
              ),
              onSubmitted: _searchLocation,
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center ?? LatLng(1.29698951191332, 103.85302201172507),
                zoom: 15,
              ),
              markers: _center != null
                  ? {
                      Marker(
                        markerId: MarkerId('busStopMarker'),
                        position: _center,
                        infoWindow: InfoWindow(title: 'Location from Search'),
                      ),
                    }
                  : Set<Marker>(),
            ),
          ),
        ],
      ),
    );
  }
}
