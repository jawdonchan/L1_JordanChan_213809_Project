import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddFavoriteBusStopPage extends StatefulWidget {
  @override
  _AddFavoriteBusStopPageState createState() => _AddFavoriteBusStopPageState();
}

class _AddFavoriteBusStopPageState extends State<AddFavoriteBusStopPage> {
  TextEditingController _busStopCodeController = TextEditingController();
  List<String> _favoriteBusStops = [];
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _getUserId();
  }

  void _getUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  void _loadFavorites() async {
    // Load user's favorite bus stops from Firestore
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('User\'s Favourites').doc(_userId).get();

    if (userDoc.exists) {
      setState(() {
        _favoriteBusStops = List.from(userDoc['favorites'] ?? []);
      });
    }
  }

  void _saveFavorites() async {
    // Save updated favorite bus stops to Firestore
    await FirebaseFirestore.instance
        .collection('User\'s Favourites')
        .doc(_userId)
        .set({'favorites': _favoriteBusStops});
  }

 void _addFavoriteBusStop() async {
  String busStopCode = _busStopCodeController.text.trim();
  if (busStopCode.isNotEmpty) {
    // Update the favorite bus stops in Firestore using FieldValue.arrayUnion
    await FirebaseFirestore.instance
        .collection('User\'s Favourites')
        .doc(_userId)
        .update({'favorites': FieldValue.arrayUnion([busStopCode])});

    setState(() {
      _busStopCodeController.clear();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Favorite Bus Stop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _busStopCodeController,
              decoration: InputDecoration(
                labelText: 'Bus Stop Code',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addFavoriteBusStop,
              child: Text('Add to Favorites'),
            ),
            SizedBox(height: 20.0),
            Text('Favorite Bus Stops:'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _favoriteBusStops.map((busStopCode) {
                return Text(busStopCode);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
