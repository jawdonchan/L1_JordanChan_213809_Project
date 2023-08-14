import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proj_layout/bus/home.dart';

class FavouriteServicesTab extends StatefulWidget {
  @override
  _FavouriteServicesTabState createState() => _FavouriteServicesTabState();
}

class _FavouriteServicesTabState  extends State<FavouriteServicesTab> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Favorite Bus Services'),
      // ),
      body: FutureBuilder(
        future: _fetchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(child: Text('No favourite bus services.'));
          }

          List<String> favoriteServices = snapshot.data;

          return ListView.builder(
            itemCount: favoriteServices.length,
            itemBuilder: (context, index) {
              final String serviceNo = favoriteServices[index];

              return Padding(
                padding: const EdgeInsets.fromLTRB(3,8,4,0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text('Service:'),
                    subtitle: Text(serviceNo, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _removeFromFavorites(serviceNo);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePageBS()), // Replace with your HomePageBS class
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  Future<List<String>> _fetchFavorites() async {
    final User user = _auth.currentUser;

    if (user != null) {
      final String userId = user.uid;

      final DocumentReference userRef =
          _firestore.collection('User\'s Favourites').doc(userId);

      final DocumentSnapshot userSnapshot = await userRef.get();

      if (userSnapshot.exists) {
        return List<String>.from(userSnapshot.data()['favorites'] ?? []);
      }
    }

    return [];
  }

  Future<void> _removeFromFavorites(String serviceNo) async {
    try {
      final User user = _auth.currentUser;

      if (user != null) {
        final String userId = user.uid;

        final DocumentReference userRef =
            _firestore.collection("User's Favourites").doc(userId);

        final DocumentSnapshot userSnapshot = await userRef.get();

        if (userSnapshot.exists) {
          final List<String> favorites =
              List<String>.from(userSnapshot.data()['favorites'] ?? []);

          if (favorites.contains(serviceNo)) {
            favorites.remove(serviceNo);
            await userRef.update({'favorites': favorites});
            setState(() {
              // Update UI if needed
            });
          }
        }
      }
    } catch (e) {
      print('Error removing from favorites: $e');
    }
  }
}