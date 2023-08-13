import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  final double latitude = 1.29698951191332;
  final double longitude = 103.85302201172507;

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15, // Adjust zoom level as needed
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Location Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: {
          Marker(
            markerId: MarkerId('busStopMarker'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: 'Bras Basah Cplx'),
          ),
        },
       
      ),
    );
  }
}
