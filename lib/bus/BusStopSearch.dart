import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proj_layout/bus/httpservice.dart';
import 'package:proj_layout/bus/BusStopArrival.dart';
import 'JsonParseBusArrival.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class BusSearch extends StatefulWidget {
  BusSearch({Key key}) : super(key: key);
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

class _HomePageState extends State<BusSearch> {
  TextEditingController _controller = TextEditingController();
  final debouncer = Debouncer(msecond: 1000);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Service> _cp;
  bool _loading = false; // Set loading to false initially

  void _searchBusServices(String searchQuery) {
    setState(() {
      _loading = true;
    });

    HttpService.getBusStop(searchQuery).then((cp) {
      setState(() {
        _cp = cp;
        _loading = false;
      });
    });
  }

 void _addToFavorites(String serviceNo) async {
  try {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;

    if (user != null) {
      final String userId = user.uid;
      final String userEmail = user.email; // Get user's email

      final DocumentReference userRef = FirebaseFirestore.instance
          .collection("User's Favourites")
          .doc(userId);

      final DocumentSnapshot userSnapshot = await userRef.get();

      // Create a new document if user's document doesn't exist
      if (!userSnapshot.exists) {
        await userRef.set({
          'email': userEmail, // Store user's email
          'favorites': [serviceNo]
        });
      } else {
        final List<String> favorites =
            List<String>.from(userSnapshot.data()['favorites'] ?? []);

        if (!favorites.contains(serviceNo)) {
          favorites.add(serviceNo);
          await userRef.update({'favorites': favorites});

           // Show SnackBar when a bus service is added to favorites
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text('Added to Favorites'),
          duration: Duration(seconds: 2), // Set the duration for the SnackBar
        ),
      );
        }
      }
    }
  } catch (e) {
    print('Error adding favorite: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _scaffoldKey, // Set the scaffold key
      // appBar: AppBar(
      //   title: Text(_loading ? 'Loading...' : 'Bus Services'),
      // ),
      //  appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back_ios, // Use any custom icon here
      //       color: Colors.black, // Set the desired color for the icon
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context); // Go back to the previous page
      //     },
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.5),
          child: Center(
            child: Column(
              children: [
                 Align(
            alignment: Alignment.topLeft,
            child: 
               Text(
                'Bus by Bus Stop Code',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
            ),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
                SizedBox(height: 20),
                searchTF(),
                SizedBox(height: 40),
                if (_loading)
                  CircularProgressIndicator() // Show loading indicator while searching
                else if (_cp != null && _cp.isNotEmpty)
                  Column(
                    children: _cp
                        .map((cpAvail) => Card(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Service No: ' +
                                          cpAvail.serviceNo
                                              .toString()
                                              .split('.')
                                              .last,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black),
                                    ),
                                      SizedBox(height: 5.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Operator: ' +
                                              cpAvail.serviceOperator,
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black87),
                                        ),
                                      IconButton(
                                              onPressed: () {
                                                _addToFavorites(cpAvail.serviceNo.toString());
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red, // Customize the color of the heart icon
                                              ),
                                            ),


                                      ],
                                    ),
                                    Text(
                                       'Est Arrival: ' + cpAvail.nextBus.estimatedArrival.toString(),
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  )
                else
                  Text('No bus services found.'),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {
                          _cp = null;
                        });
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _searchBusServices(_controller.text);
                        }
                      },
                      child: Text('Next'),
                    )
                  ],
                ),
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
        contentPadding: EdgeInsets.all(5.0),
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


