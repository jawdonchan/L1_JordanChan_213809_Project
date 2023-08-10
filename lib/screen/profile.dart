import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User _user; // Holds the currently logged-in user
  String _username; // Holds the trimmed username from email

  @override
  void initState() {
    super.initState();
    // Get the current user from Firebase Authentication
    _user = FirebaseAuth.instance.currentUser;

    // Extract the username from the email address
    _username = _user.email.split('@')[0];
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
                        // Display user's profile picture if available
                        // backgroundImage: _user.photoURL != null ? NetworkImage(_user.photoURL) : AssetImage('assets/default_avatar.png'),
                        radius: 50,
                        // Placeholder image in case the user has no profile picture
                        // backgroundImage: AssetImage('assets/default_avatar.png'),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Username: $_username', // Display the trimmed username
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            'Email: ${_user.email}',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Navigate to the update profile page when the button is pressed
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => UpdateProfilePage(),
              //   ),
              // );
            },
            child: Text('Update Profile'),
          ),
        ],
      ),
    );
  }
}
