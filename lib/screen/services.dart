import 'package:flutter/material.dart';
import 'package:proj_layout/screen/home.dart'; 
import 'package:proj_layout/screen/profile.dart'; 
import 'call.dart';
import 'topup.dart';
import 'maps.dart';
import 'about.dart';
import 'email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:search.dart'; 

final FirebaseAuth _auth = FirebaseAuth.instance;
User currentUser = _auth.currentUser;
final userEmail = currentUser.email;
class ServicesPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Services'),
      // ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 3, // 3 columns in the grid
                padding: EdgeInsets.all(20.0),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  _iconWithBorder(
                    context,
                    icon: Icons.redeem,
                    title: 'Reward',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.credit_card,
                    title: 'Concession',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SearchPage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.attach_money_rounded,
                    title: 'Top Up',
                    onPressed: () {
                      Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddValuePage(userEmail: userEmail),
            ),
          );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.calculate,
                    title: 'Fare Calculator',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SearchPage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.location_pin,
                    title: 'Location',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapScreen()),
                      );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.person,
                    title: 'Profile',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.call,
                    title: 'Call',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CallPage()),
                      );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.email,
                    title: 'Email',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EmailPage()),
                      );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.check_circle_rounded,
                    title: 'About Us',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconWithBorder(BuildContext context,
      {IconData icon, String title, Function onPressed}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(icon),
            onPressed: onPressed,
          ),
          Flexible(child: Text(title)),
        ],
      ),
    );
  }
}
