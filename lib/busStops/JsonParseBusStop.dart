import 'dart:async';
import 'package:flutter/material.dart';
import 'httpservice.dart';
import 'BusStop.dart';
import 'BusStopMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';


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

    final List<String> imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fmrt.jpg?alt=media&token=2c34b966-4dab-4d1e-9445-df6289b4b56b',
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fneline.png?alt=media&token=51691724-d59b-4c7c-b6d2-a366a11af672',
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fweb_banner.jpg?alt=media&token=770edc82-fced-4b45-a398-571f51d58306',
    'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fbanner2.png?alt=media&token=9ff9ed6b-3af8-447c-9d2c-4fd903a35b5c',
  ];

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           CarouselSlider(
                items: [
                  'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fweb_banner.jpg?alt=media&token=770edc82-fced-4b45-a398-571f51d58306',
                  'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fbanner2.png?alt=media&token=9ff9ed6b-3af8-447c-9d2c-4fd903a35b5c',
                  'https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/banner%2Fmrt.jpg?alt=media&token=2c34b966-4dab-4d1e-9445-df6289b4b56b',
                ].map((imageUrl) {
                  return Container(
                    width: 650,
                      padding: EdgeInsets.all(8.5),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.black, width: 2),
                        // borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    
                  );
                }).toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 400),
                  viewportFraction: 0.98,
                  height: 200,
                ),
              ),
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