import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  final double latitude;
  final double longitude;

  MapPage({this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 15.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Stop Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: {
          Marker(
            markerId: MarkerId('busStopMarker'),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: 'Bus Stop Location'),
          ),
        },
      ),
    );
  }
}
