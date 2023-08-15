import 'package:flutter/material.dart';
import 'package:proj_layout/bus/home.dart';
import 'package:proj_layout/busStops/JsonParseBusStop.dart';
import 'package:proj_layout/screen/card_user.dart';
import 'package:proj_layout/screen/maps.dart';
import 'user_favourites.dart';
import 'package:provider/provider.dart';
import 'profile.dart';
import 'services.dart';
import 'package:firebase_auth/firebase_auth.dart'; // for user auth
import 'package:cloud_firestore/cloud_firestore.dart'; // for collection in db

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _pageTitle = 'Home'; // Initial title
 
  final List<Widget> _pages = [
    BusStopsJsonParse(), 
    FavouritesPage(),
    UserCardsPage(),
    ServicesPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      // Update the title based on the selected page
      switch (_currentIndex) {
        case 0:
          _pageTitle = 'Home';
          break;
        case 1:
          _pageTitle = 'Saved';
          break;
        case 2:
          _pageTitle = 'Card';
          break;
        case 3:
          _pageTitle = 'Services';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        //  leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios, // Use any custom icon here
        //     color: Colors.black,
        //     size: 25, // Set the desired color for the icon
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context); // Go back to the previous page
        //   },
        // ),
        title: Text(
          _pageTitle,
          style: TextStyle(color: Colors.black), // Set the text color
        ),
         actions: [
        StreamBuilder<User>(
  stream: FirebaseAuth.instance.authStateChanges(),
  builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (!snapshot.hasData || snapshot.data == null) {
      return Text('Not Logged In');
    }

    final user = snapshot.data;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('User Details')
          .doc(user.uid) // Fetch document using user's UID
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (!userSnapshot.hasData || !userSnapshot.data.exists) {
          return Text('Profile Not Made');
        }

        final userData = userSnapshot.data.data();

        String username = userData['name'] ?? 'N/A';
        String profilePicUrl = userData['profilepic'] ?? '';

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // Navigate to the user's profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(), // Replace with your profile page
                  ),
                );
              },
              child: CircleAvatar(
                backgroundImage: profilePicUrl.isNotEmpty
                    ? NetworkImage(profilePicUrl)
                    : NetworkImage('https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/profile%2Fdefault.jpg?alt=media&token=33a2f9e5-35be-42ff-8ac8-2dd8cdb69bf8'),
                backgroundColor: Colors.blueAccent,
                radius: 16,
              ),
            ),
            SizedBox(width: 8),
            Text(
              username,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16),
          ],
        );
      },
    );
  },
),
        ],
        // title: Text('My App'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.deepPurple, // Change the selected icon color here
        unselectedItemColor:
            Colors.grey, // Change the unselected icon color here
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Services',
          ),
        ],
      ),
    );
  }
}


