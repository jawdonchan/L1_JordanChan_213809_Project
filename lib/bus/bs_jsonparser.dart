import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proj_layout/bus/httpsevice.dart';
import 'package:proj_layout/bus/buses.dart';

class CPJsonParse extends StatefulWidget {
 
  // CPJsonParse({Key key}) : super(key: key);
  @override
  _CPJsonParseState createState() => _CPJsonParseState();
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

class _CPJsonParseState extends State<CPJsonParse> {
  final _controller = TextEditingController();
  final debouncer = Debouncer(msecond: 1000);
  List<Service> _cp;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getBusStop(_controller.text).then((cp) {
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
        title: Text(_loading ? 'Loading...' : 'Bus Availibility'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            searchTF(),
            Text(_controller.text),
            Expanded(
              child: ListView.builder(
                itemCount: null == _cp ? 0 : _cp.length,
                itemBuilder: (context, index) {
                  Service cpAvail = _cp[index];
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus Number: ' +
                                cpAvail.serviceNo.toString().split('.').last,
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.black),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Lat: ' + cpAvail.nextBus.latitude,
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black87),
                                ),
                              ),
                              Text(
                                'Long: ' + cpAvail.nextBus.longitude.toString(),
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black87),
                              ),
                            ],
                          ),
                          Text(
                            'Load : ' + cpAvail.nextBus.load.toString(),
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black87),
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

  Widget searchTF() {
    return TextField(
      controller: _controller,
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
          HttpService.getBusStop(_controller.text).then((uCp) {
            setState(() {
              _cp = Service.filterList(uCp, string);
            });
          });
        });
      },
    );
  }
}
