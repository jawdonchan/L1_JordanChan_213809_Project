import 'dart:async';
import 'package:flutter/material.dart';

import 'package:proj_layout/bus/httpservice.dart';
import 'package:proj_layout/bus/BusStopArrival.dart';
import 'JsonParseBusArrival.dart';
class HomePageBS extends StatefulWidget {
  HomePageBS({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
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

class _HomePageState extends State<HomePageBS> {
  TextEditingController _controller = new TextEditingController();
  final debouncer = Debouncer(msecond: 1000);
  List<Service> _cp;
  bool _loading;
  @override
  void initState() {
    super.initState();
    _loading = true;
    HttpService.getBusStop(_controller.toString()).then((cp) {
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
        title: Text(_loading ? 'Loading...' : 'Bus Services'),
      ),
      // body: home(),
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                // Image(
                //   image: AssetImage('images/bus-service-icon.png'),
                //   height: 180,
                //   width: 180,
                // ),
                SizedBox(height: 50,),
                searchTF(),
                SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _controller.clear,
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JsonParseBusArrvial(
                                jsoncontroller:_controller.text,
                              )),
                        );
                      },
                      child: Text('Next'),
                    )
                  ],
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: null == _cp ? 0 : _cp.length,
                //     itemBuilder: (context, index) {
                //       Service cpAvail = _cp[index];

                //       return Card(
                //         child: Padding(
                //           padding: EdgeInsets.all(10.0),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 'Service No: ' + cpAvail.serviceNo.toString().split('.').last,
                //                 style:
                //                     TextStyle(fontSize: 16.0, color: Colors.black),
                //               ),
                //               SizedBox(height: 5.0),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Text(
                //                     'Est Arrival: ' + cpAvail.serviceOperator,
                //                     style: TextStyle(
                //                         fontSize: 14.0, color: Colors.black87,
                //                         // fontWeight: FontWeight.bold
                //                         ),
                //                   ),
                //                   Text(
                //                     'Next Bus: ' +
                //                         cpAvail.nextBus.toString(),
                //                     style: TextStyle(
                //                         fontSize: 14.0, color: Colors.black87),
                //                   ),
                //                 ],
                //               ),
                //                Text(
                //                     'Next Bus Two: ' +
                //                         cpAvail.nextBus2.toString(),
                //                     style: TextStyle(
                //                         fontSize: 14.0, color: Colors.black87),
                //                   ),
                //             ],
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchTF() {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: 'Bus Stop Code',
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white60,
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by Bus',
      ),
      onChanged: (string) {
        debouncer.run(() {
          HttpService.getBusStop(_controller.toString()).then((uCp) {
            setState(() {
              _cp = Service.filterList(uCp, string);
            });
          });
        });
      },
    );
  }
}

// Widget home() {
//   return Center(
//     child: Column(
//       children: [
//         Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
//         Image(
//           image: AssetImage('images/bus-service-icon.png'),
//           height: 180,
//           width: 180,
//         ),
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: 'Bus Stop Code',
//             border: OutlineInputBorder(),
//             filled: true,
//             fillColor: Colors.white60,
//             contentPadding: EdgeInsets.all(15.0),
//             hintText: 'Filter by Bus',
//           ),
//           onChanged: (string) {
//             debouncer.run(() {
//               HttpService.getBusStop().then((uCp) {
//                 setState(() {
//                   _cp = Service.filterList(uCp, string);
//                 });
//               });
//             });
//           },
//         ),
//       ],
//     ),
//   );
// }
