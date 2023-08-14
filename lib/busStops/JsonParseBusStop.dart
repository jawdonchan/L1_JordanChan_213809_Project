import 'dart:async';
import 'package:flutter/material.dart';
import 'httpservice.dart';
import 'BusStop.dart';
import 'BusStopMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class BusStopsJsonParse extends StatefulWidget {
  BusStopsJsonParse({Key key}) : super(key: key);
  @override
  _BusStopsJsonParseState createState() => _BusStopsJsonParseState();
}

class Debouncer {
  final int msecond;
  VoidCallback action;
  Timer _timer;
  Debouncer({this.msecond});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: msecond), action);
  }
}

class _BusStopsJsonParseState extends State<BusStopsJsonParse> {
  final debouncer = Debouncer(msecond: 1000);
  List<Value> _cp;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getBusStops().then((cp) {
      setState(() {
        _cp = cp;
        _loading = false;
      });
    });
  }

void _navigateToMapPage(double latitude, double longitude) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapPage(
          latitude: latitude,
          longitude: longitude,
        ),
      ),
    );
  }



 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          searchTF(),
          Expanded(
            child: ListView.builder(
              itemCount: null == _cp ? 0 : _cp.length,
              itemBuilder: (context, index) {
                Value cpAvail = _cp[index];
                return GestureDetector(
                  onTap: () {
                    _navigateToMapPage(cpAvail.latitude, cpAvail.longitude);
                  },
                  child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BusStopCode: ' + cpAvail.busStopCode.toString().split('.').last,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location: ' + cpAvail.roadName,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                            child:
                            Text(
                              'Description: ' + cpAvail.description.toString(),
                              style: TextStyle(fontSize: 14.0, color: Colors.black87),
                            ),
                            ),
                             Icon(
                                Icons.map, // Add an icon indicating the map
                                color: Colors.blue,
                              ),
                          ],
                        ),
                        SizedBox(height: 10.0), // Added spacing for the map

                       
                      ],
                    ),
                  ),
                ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget searchTF() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(5.0),
          ),
        ),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by Bus Stop Code',
      ),
      onChanged: (string) {
        debouncer.run(() {
          // setState(() {
          //   title = 'Searching..';
          // });
          HttpService.getBusStops().then((uCp) {
            setState(() {
              _cp = Value.filterList(uCp, string);
            });
          });
        });
      },
    );
  }
}
