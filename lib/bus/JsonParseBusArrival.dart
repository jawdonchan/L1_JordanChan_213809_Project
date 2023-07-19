import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proj_layout/bus/httpservice.dart';
import 'package:proj_layout/bus/BusStopArrival.dart';

class JsonParseBusArrvial extends StatefulWidget {
  final String jsoncontroller;
  JsonParseBusArrvial({Key key, this.jsoncontroller}) : super(key: key);
  @override
  _JsonParseBusArrvialState createState() => _JsonParseBusArrvialState();
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

class _JsonParseBusArrvialState extends State<JsonParseBusArrvial> {
  final debouncer = Debouncer(msecond: 1000);
  List<Service> _cp;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getBusStop(widget.jsoncontroller).then((cp) {
      setState(() {
        _cp = cp;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Bus Arrival'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(widget.jsoncontroller),
            Expanded(
                  child: ListView.builder(
                    itemCount: null == _cp ? 0 : _cp.length,
                    itemBuilder: (context, index) {
                      Service cpAvail = _cp[index];

                      var latitude2 = cpAvail.nextBus.latitude;
                      return Card(
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Service No: ' + cpAvail.serviceNo.toString().split('.').last,
                                    style:
                                        TextStyle(fontSize: 16.0, color: Colors.black),
                                  ),
                                  SizedBox(width: 20,),
                                   Flexible(
                                      child: Text(
                                      'Est Arrival: ' + cpAvail.nextBus.estimatedArrival.toString(),
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black87,
                                          // fontWeight: FontWeight.bold
                                          ),
                                  ),
                                   ),
                                  
                                ],
                              ),
                              SizedBox(height: 5.0),
                              //  Text(
                                     
                              //           cpAvail.nextBus.estimatedArrival),
                              //       style: TextStyle(
                              //           fontSize: 14.0, color: Colors.black87),
                              //     ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 
                                  Text(
                                    'Lat: ' +
                                        latitude2,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black87),
                                  ),
                                  // SizedBox(width: 10,),
                                  Flexible(
                                          child: Text(
                                      'Long: ' +
                                          cpAvail.nextBus.longitude,
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.black87),
                                    ),
                                  ),
                                  Text(
                                    'Load: ' +
                                        cpAvail.nextBus.load.toString(),
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black87),
                                  ),
                                 IconButton(icon: Icon(Icons.directions), onPressed: null),
                                ],
                              ),
                              
                                   
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
