import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'updateprofile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user; // Holds the currently logged-in user
  String _username; // Holds the user's name from the collection
  String _profilePicUrl; // Holds the user's profile picture URL

  @override
  void initState() {
    super.initState();
    // Get the current user from Firebase Authentication
    _user = FirebaseAuth.instance.currentUser;

    // Retrieve user details from Firestore based on the user's email
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final userDetailsSnapshot = await FirebaseFirestore.instance
          .collection('User Details')
          .where('email', isEqualTo: _user.email)
          .get();

      if (userDetailsSnapshot.docs.isNotEmpty) {
        final userDetails = userDetailsSnapshot.docs[0];
        final name = userDetails['name'];
        final profilePicUrl = userDetails['profilepic'];

        setState(() {
          _username = name != null ? name : "N/A";
          _profilePicUrl = profilePicUrl != null ? profilePicUrl : "";
        });
      }

      // Fetch the user's display name from Firebase Authentication
      if (_user.displayName != null) {
        setState(() {
          _username = _user.displayName;
        });
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 2.0),
                      ),
                      child: CircleAvatar(
                        backgroundImage:
                            _profilePicUrl != null && _profilePicUrl.isNotEmpty
                                ? NetworkImage(_profilePicUrl)
                                : NetworkImage('https://firebasestorage.googleapis.com/v0/b/findmyline-c419e.appspot.com/o/profile%2Fdefault.jpg?alt=media&token=33a2f9e5-35be-42ff-8ac8-2dd8cdb69bf8'),
                        radius: 50,
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          'Username: $_username', // Display the user's name
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Email: ${_user.email}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              //Navigate to the update profile page when the button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProfilePage(),
                ),
              );
            },
            child: Text('Update Profile'),
          ),
        ],
      ),
    );
  }
}
