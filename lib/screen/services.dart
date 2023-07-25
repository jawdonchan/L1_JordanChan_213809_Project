import 'package:flutter/material.dart';
import 'package:proj_layout/screen/home.dart'; // Replace this with the file path for the home page
// import 'package:search.dart'; // Replace this with the file path for the search page
// import 'package:proj_layout/favorites_page.dart'; // Replace this with the file path for the favorites page

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
                    icon: Icons.home,
                    title: 'Home',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.search,
                    title: 'Search',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SearchPage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.favorite,
                    title: 'Favourite',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => FavoritesPage()),
                      // );
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => SearchPage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.person,
                    title: 'Profile',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ProfilePage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.call,
                    title: 'Call',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ProfilePage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.email,
                    title: 'Email',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ProfilePage()),
                      // );
                    },
                  ),
                  _iconWithBorder(
                    context,
                    icon: Icons.check_circle_rounded,
                    title: 'About Us',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ProfilePage()),
                      // );
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
