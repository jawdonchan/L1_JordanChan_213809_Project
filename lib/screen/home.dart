import 'package:flutter/material.dart';
import 'package:proj_layout/main.dart';
import 'nextpage.dart';
import 'login.dart';
import 'package:provider/provider.dart';
import 'services.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _pageTitle = 'Home'; // Initial title

  final List<Widget> _pages = [
    Page1(), // Replace Page1, Page2, Page3, and Page4 with your actual pages.
    Page2(),
    Page3(),
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
          _pageTitle = 'Search';
          break;
        case 2:
          _pageTitle = 'Favorites';
          break;
        case 3:
          _pageTitle = 'Settings';
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
    // Add the user icon and username here
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          // Use your user icon image here
          // backgroundImage: AssetImage('assets/user_icon.png'),
          backgroundColor: Colors.blueAccent,
          radius: 16,
        ),
        SizedBox(width: 8),
        Text(
          'Username',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 16), // Add some space between the icon and username
      ],
    ),
  ],
        // title: Text('My App'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.blue, // Change the selected icon color here
        unselectedItemColor: Colors.grey, // Change the unselected icon color here
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Replace Page1, Page2, Page3, and Page4 with your actual page widgets.
class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Page'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Page'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorites Page'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}
