import 'dart:async';
import 'package:flutter/material.dart';
import 'httpservice.dart';
import 'BusStop.dart';
import 'BusStopMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';


class FavBusStop extends StatefulWidget {
  FavBusStop({Key key}) : super(key: key);
  @override
  _FavBusStopState createState() => _FavBusStopState();
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

class _FavBusStopState extends State<FavBusStop> {
  final debouncer = Debouncer(msecond: 1000);
  List<Value> _cp;
  bool _loading;

  List<String> _favoriteBusStops = []; // Store favorite bus stop codes

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

  void _toggleFavorite(String busStopCode) {
    setState(() {
      if (_favoriteBusStops.contains(busStopCode)) {
        _favoriteBusStops.remove(busStopCode);
      } else {
        _favoriteBusStops.add(busStopCode);
      }
    });
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
                bool isFavorite = _favoriteBusStops.contains(cpAvail.busStopCode);
                return GestureDetector(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BusStopCode: ' +
                                cpAvail.busStopCode.toString().split('.').last,
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Location: ' + cpAvail.roadName,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  'Description: ' +
                                      cpAvail.description.toString(),
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black87),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _toggleFavorite(cpAvail.busStopCode);
                                },
                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : null,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
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
      ),
    );
  }
}